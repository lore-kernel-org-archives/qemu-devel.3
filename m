Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4FD606C69F
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 20:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FW02Koev;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eTW7I59c
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU8YO-0002n2-5Y; Thu, 19 Nov 2026 15:16:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xU8YI-0002lP-1c
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 15:16:14 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xU8YE-0000ps-T8
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 15:16:13 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJJ1jTW1936633
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 20:16:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yy3iZQOxjbn7sUE2fzUieBZDlaV7AekfIbOCamTwD8Q=; b=FW02KoevKkHE0577
 tS0P8sV/I2JyZjjwZ2ju8lYosHDm5K1MVIfp5mbTTyvT9oCR+AxFRZLlmi3XzPYH
 6cYIzbxuuwKK2y71WxtZYFG+588FjPdZmWQB8iFFz1q9/9O8YwUy1QX3qYtxjhhu
 srVhxycH6t8b7iOTZLCaZI0R3Dt0ses4sxfNZIyWRil8QE4BK4BwL7MbJ+Jfaq7N
 03PbxYk+NJh0TVXMSyVsyFc2TxqV0MUtVi2IKGwGFQpPnwngAPDCi+HeWptGYOaQ
 Vv2qX+hB/OIw8BnnmDKy3qZ5XpX9klJb1TiEzP5DLHAt+u7M3SMwTBBRnebYrKKf
 ssWf8Q==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j22ugssrh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 20:16:09 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-384c78aa0dbso143878eec.0
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 12:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795119368; x=1795724168; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yy3iZQOxjbn7sUE2fzUieBZDlaV7AekfIbOCamTwD8Q=;
 b=eTW7I59cRkEQr4qkRATuMq4cuebnDx0QSRSZ9R8C0KtGFlMocSXzH/FCYUYWHJ7IEM
 6g1n0daaW6MSaTdjk5HNMF4BzgdZx8xSz8VLIDOsUakOzgx7rmdGQHfe/NizHeV1qOae
 N4RjCLTzNgRKeVDz53Q2XAh5Layirn0YZ03DtTLsCPYV8h7A8VQ1RZWyuuC038jNaOHp
 z7s+xXKpg//j/fv0WJaIdoTvfzjogFi/c1Hivj1orXREviHIA7my0YCeDFc/RZyM7GHo
 DtEBcefLlbfAWsIZOiJ/isCd5JdqfeqlEOtdpVMIPGl2PBMkO2JsL5Lf2zR1mOtwFfTz
 XdPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795119368; x=1795724168;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yy3iZQOxjbn7sUE2fzUieBZDlaV7AekfIbOCamTwD8Q=;
 b=1Z8ZRtPPKtWUXC5zFSI9UPz6BVGEzeOgynL2Z7V8w2jz9IBRXC407ZSyzAHrQLmtPq
 /SwMKN+2nPeLYYF+AhtaOZE1LV1G1HhWmORwNIjiA277ENEa7gn/LHp9ioZ+SzYot36y
 xPOnHNCSy88wxDngyOlNo7LfcmqHec2u55WIGtYPIJVgXDhfpca4mq+uVsMPYm3Pr/TA
 0kPkZfVh24B2eZrz9AjnQOB0u5GeUOYCOKO8+xaBBK+6+UiZ4jAQ3hYrUJe1K7cqo06B
 wEgLsaT35/wPWd4kB0aSxcX8oT6oNBltRju9WN2JIsm4SI48Cxz8XrWhbh2oTGLippaX
 ARig==
X-Gm-Message-State: APuU4Z+/dp+taKd++/nkxFGH0gZba8NMABsuTYi+FnosQEVy7fHSXfoZ
 ONkwl+ESwprGJ1o0pnfRqWYlyvKX69J/TaUwpmzYh/irYcfCq7FHS2eA1NsPDNjCfqMrNWZU8Km
 u6F59tGHqPaWAyninwiZbkabr1c860ZsR1+wN3/2SiD8wjfXJpr8S8mdvpf1RxsrFqw==
X-Gm-Gg: AZFdTZeT1JBThW8nY4lR/9SqZfPlTdZ2AmxNJmxI18sbSAMA/TyQP52qnm6V142UAlc
 PU2tWd4/gO9oeQCGLxrfA41C0e/1kzczani9CkhccBZHxeuS5LjTOPA3wQBnGLjZ17HsS0SiIyv
 SJ9Jru+x9ATRM5au3Oc416yni3YolUPs4UH/jDrhjS7v4yBvuyDcAeU9j9PjJh7GoF9Sv/xlnra
 ClaWGqBgcBnxxy3/a48k/jQUGy3ARiPvEcBWRpi19g49HetLMVtAlBJMhqv/G4trw52J1xRVU7g
 C2o9pts87+HT6fImBm4u9XYVZ1trU9/mbb+TgnBwI/9tXfB7wJC797D4B3DIPb/wCcFPoS2suJ+
 1uv5YVsZlbnuH1kPRit6Q7O7XPAk29JKdvZkmaOkb/HtkV9vogWTu+O9BwLgO6Br9jQ2roJflFt
 +ZKu345sRX+ErvUOnXG6q+5g==
X-Received: by 2002:a05:693c:864c:10b0:377:a1c8:a628 with SMTP id
 5a478bee46e88-3856f65dc4fmr450952eec.6.1795119368550; 
 Thu, 19 Nov 2026 12:16:08 -0800 (PST)
X-Received: by 2002:a05:693c:864c:10b0:377:a1c8:a628 with SMTP id
 5a478bee46e88-3856f65dc4fmr450923eec.6.1795119367907; 
 Thu, 19 Nov 2026 12:16:07 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385616f0a3fsm1132085eec.0.2026.11.19.12.16.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 12:16:07 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Peter Xu <peterx@redhat.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH-for-11.2 02/14] target/hexagon: bound packet lookahead to the
 current page
Date: Thu, 19 Nov 2026 12:15:51 -0800
Message-Id: <20261119201603.2377989-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261119201603.2377989-1-brian.cain@oss.qualcomm.com>
References: <20261119201603.2377989-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: KoV9VSzzG3Y4UfIgAd7Bq1Y--sh6CKwh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA4MCBTYWx0ZWRfXwghmvG9Jexvv
 XxPJqCUtb8Zw3fvm9uZBuaHk3zhiqLFOL2j2onJkehwdtPXX65OofUdbCKwGmEqrcdHJHWCwVTN
 Dln6U6gFv3KSgfuLLy3oFKb1HXYOWmE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA4MCBTYWx0ZWRfX6cjjElR7YE82
 xok+dHFMgvI/VAaflPsmO0f2AmcoySri9IholoiwM5dqUV7+n/KChMsTUS6QVpUER6zufUFV5om
 1jLDPok0X2CykfhuUkJmo98sRqTEqzUZ7lQuUvw8APINNPgQKizNB4y/hYTNnAJPdpyVdD+1wZS
 eAVsQyqghdykTE6OE0K0sRQTALyoKz+mY9uq1aBTuo7EcO2+dXLTABsW/aj9J47Zyw55O2qyQYl
 4L12BX1ZnoFvFVBq6ZYQByCO6uTHnyTd7pP1xkTWcdkynXuucIjNYr/ICw1kRMexcZUu1eiywFG
 IIrzUkaWp3pwIHzPc9e5Yh+Tx/yS8Y59tALNswgnkUT3PC+pduCfuJzADFwBv6dQJ2hiCmpYCqH
 2pdSVfP/kQ1JnbpbjlMuW/4VN3t7etNTA5tp7/5RzTGzLGyMicId/q8fwAbX7r3bJ2XrfhVttQX
 Yf6poCMrJNCCPUkRYEQ==
X-Authority-Analysis: v=2.4 cv=YeEodARf c=1 sm=1 tr=0 ts=6aff5909 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=LOdbtK4x63e5lU4mKCMA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: KoV9VSzzG3Y4UfIgAd7Bq1Y--sh6CKwh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 bulkscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190080
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

RnJvbTogTWFyY28gTGllYmVsIDxtYXJjby5saWViZWxAb3NzLnF1YWxjb21tLmNvbT4KCkRvIG5v
dCBmZXRjaCBhbiB1bm1hcHBlZCBwYWdlIHdoaWxlIGRlY2lkaW5nIHdoZXJlIHRvIGVuZCBhIFRC
LgpUaGlzIGxldHMgY29tcGxldGUgcGFja2V0cyByZXRpcmUgYmVmb3JlIGEgc3RyYWRkbGluZyBw
YWNrZXQgZmF1bHRzLAphbmQgcHJlc2VydmVzIHRoZSBjb3JyZWN0IHBhY2tldCByZXN0YXJ0IGFk
ZHJlc3MuCgpTaWduZWQtb2ZmLWJ5OiBNYXJjbyBMaWViZWwgPG1hcmNvLmxpZWJlbEBvc3MucXVh
bGNvbW0uY29tPgpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmll
ckBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jIHwgNSAr
KysrKwogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3Rhcmdl
dC9oZXhhZ29uL3RyYW5zbGF0ZS5jIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKaW5kZXgg
ZWMxZDc5ZTMxZjYuLjQxYTBmMmIwODUyIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi90cmFu
c2xhdGUuYworKysgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYwpAQCAtMTYyMCw2ICsxNjIw
LDExIEBAIHN0YXRpYyBib29sIHBrdF9jcm9zc2VzX3BhZ2UoQ1BVSGV4YWdvblN0YXRlICplbnYs
IERpc2FzQ29udGV4dCAqY3R4KQogICAgIGludCBud29yZHM7CiAKICAgICBmb3IgKG53b3JkcyA9
IDA7ICFmb3VuZF9lbmQgJiYgbndvcmRzIDwgUEFDS0VUX1dPUkRTX01BWDsgbndvcmRzKyspIHsK
KyAgICAgICAgLyogTG9vayBhaGVhZCBvbmx5IG9uIHRoaXMgcGFnZTsgYSBmYXVsdCBtdXN0IG5v
dCBkaXNjYXJkIHRoaXMgVEIuICovCisgICAgICAgIGlmIChjdHgtPmJhc2UucGNfbmV4dCArIG53
b3JkcyAqIHNpemVvZih1aW50MzJfdCkgLSBwYWdlX3N0YXJ0ID49CisgICAgICAgICAgICBUQVJH
RVRfUEFHRV9TSVpFKSB7CisgICAgICAgICAgICByZXR1cm4gdHJ1ZTsKKyAgICAgICAgfQogICAg
ICAgICB1aW50MzJfdCB3b3JkID0gdHJhbnNsYXRvcl9sZGxfZW5kKGVudiwgJmN0eC0+YmFzZSwK
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjdHgtPmJhc2UucGNf
bmV4dAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICsgbndvcmRz
ICogc2l6ZW9mKHVpbnQzMl90KSwKLS0gCjIuMzQuMQoK

