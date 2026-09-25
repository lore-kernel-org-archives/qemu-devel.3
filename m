Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 060C9C98318
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 01:57:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9vAQ-0006fC-CZ; Thu, 24 Sep 2026 21:56:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9vAI-0006H2-Eb
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:55:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9vAE-0006Bg-J4
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:55:54 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P1lQrB3885778
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:55:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OQ5RaKyuEciAXfaMVoDzP/XmPFNA4e6v5saZuF89tis=; b=OEe59FYSw5pVdKHL
 HCu/fqUH/U8wR/xw5CDPl3GDmvpIvg62B46WBKsorkETEPtPQN+zKBKV0XCLoEUO
 a2CQ+I0HYRJJxflj9/e81h17MyTa+OJjwJL6Q2Qbxyh8LA1qIdwCFW9AHNKY9RiA
 /P8yH34Pfxa/CJKSnItAARBlgg6Rs/Fu2XbwrndmYns9ehQSTk6GSugQHgmITUHU
 yDxiC1k7OWD7YqY4eoU/P2BUH+EPs3E77RkNIYvsBq3JHkKk2p7ghHT8M6I8Agk7
 jvS9zZme3vdTBKLdbu/yYhDRHYXU/rrLOphOTD16sQWbtvsznVkw+0Tsyw+9G/Lz
 BI2qfg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw4652s59-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:55:39 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-33baaba6371so1436559eec.1
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 18:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790301339; x=1790906139; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OQ5RaKyuEciAXfaMVoDzP/XmPFNA4e6v5saZuF89tis=;
 b=CnK1Ywm+7f/sqdud2aB/ehHRuHCgPBUj/A63K4R5ZcG9BQv0ezKJ09grxinRz3ICLE
 UoYxAnBemNxF6GdSEb5cMr010HZxk1+UHBbhPYwChZHrrwvmog6JLHcA6acYphnyGzL0
 FURJDGH4U+HRWcLObxw2fz/ONHRIbN+C3rVT+Cn1kosPE3aa5YDOxmgZqz5Q7m64mPj7
 6gmKu9zbR9f7E3XypBy8sJiemcvbxc5qobHflHIDH+phpVRS5TcUiFIa8pZXAlfsfmil
 V+dkAjpQZ6jKLqAQOTUYuBcf4iPnONwbU/u/LOwO5yHsaPmqzKHHoh81yq0tfx9oVaB0
 i4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790301339; x=1790906139;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OQ5RaKyuEciAXfaMVoDzP/XmPFNA4e6v5saZuF89tis=;
 b=0yB6KRNCNY/f23CdKw28KPEjCQsavlLK44UJTc3vw7kP+lLkD4QmFGs64jcad8dOSy
 8GiGImffywHVdNcFLSp8r73BzCsCsQP5VJLCol2+ZfO3/nsSTxrhP5vJKybWYV5FpCLg
 togZU2Ff6Qg+GKKZ6fygj74dRtOn2BI5mg0igugNGYwPzNIXfLtkGbqUdD4BVyo/mpaS
 BD4FE8JeA7FZGTUBZL/n2SY0LBv2+xr/SrOhn3sLra+HY7W5oOl1hHrmuakmcWcl/h+m
 zK23Hy4V8mVzZC6FJer3wJ5VpuynP64gqtHAzVJsZIEXbrUceC+Dl3ep6AYhj41HEDb5
 kQDg==
X-Gm-Message-State: AFuF++k+2neCKxn/UeatAEx5lKVIqSe9HRqOi8gRIIfdPqw5DFT/AIWv
 qNdkGKweNakZfXQAJpXXPY6vSdGCf4RBuBKlAs+jpVdjecSJxg1x/wo4b1rXDzvSuQsyCTyGjuX
 Yu+XKxzhWdQFeKrTRuoKPrvnriDikHqpwenRR7a5LiEgWtw1aSo+WYJPPRy5phVXOfw==
X-Gm-Gg: AYBFou3fIdmOVL648I7si73+qvRUCLiypjHJFfBM3SI7IiHP4yDcpOyk6arzSC8uGWj
 hUG+BOlOV4S+j5ZZb9X5EY5PHMtM5fvymISNfde+pW0hheNsWRwjWqIqYjRzrLPo7RXfEW3J43b
 TJwcqThFZIgT9hvPVKs2tm394Zo49R1ZO0DWYJ4oPCXmONiK4sPG5731AI3NWr2RLkNw0jCRAQ7
 sFdKVXV3l9Qli+urM7Tmxbw/EBAOvZeOdSGZiL+vQCaKTBoLC8y0LuTs/1HCAMU/S0GOJahzhir
 0WthYFKH7jb3mirw/vHR1EWeY5l70fEqozXwV1rnjODbiy60CjDjGvxC9N5Jdd15pGazGC+KzhX
 VDIDt3cmikM1x1tlhNeBnnbhD5lY8Cf/tu3laima6k/I0/KA=
X-Received: by 2002:a05:693c:88ce:10b0:33e:633c:7f70 with SMTP id
 5a478bee46e88-34003ab0075mr3464303eec.35.1790301338544; 
 Thu, 24 Sep 2026 18:55:38 -0700 (PDT)
X-Received: by 2002:a05:693c:88ce:10b0:33e:633c:7f70 with SMTP id
 5a478bee46e88-34003ab0075mr3464286eec.35.1790301337923; 
 Thu, 24 Sep 2026 18:55:37 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3416e4c2f50sm1873720eec.27.2026.09.24.18.55.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 18:55:37 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 34/40] tests/functional/hexagon: add HVX tests
Date: Thu, 24 Sep 2026 18:54:23 -0700
Message-Id: <20260925015429.2579174-35-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
References: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=Wrq+otfv c=1 sm=1 tr=0 ts=6ab5d49b cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=eq6FigJt9aAjue5lDr8A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: YGybc43m3yQCtO7hwwoN-fKlyCmKcypt
X-Proofpoint-GUID: YGybc43m3yQCtO7hwwoN-fKlyCmKcypt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfX/a8MSwTAmyMD
 05DXpgNaduKETXr4Q53oHkCJtfqt2/UQYUWdzf/lQTTLJZnR62Nungg/98B8xzvOZU5RDILWcei
 NSGuXF2HLcfn8dcSvtErb36CAwMpIuGZAzRA4HwgzEDJFbznzIiX81xPtvGYcCZXfa3fYcF33U1
 ksD3WgWJj1vEQM14ymiHwoD5ZOc+rhx7oMtgr5EHjQ4ugxHW+FIA/SJeXMPIMLJE5yMQOgg4a/Y
 8RfK8q9ZGnSKB7BO0q4IMdThrocSnJSpvMHNEQQGDrrJf418vHJzPBV/2/6RNSxH76YjRnrwrsm
 LZfsYOv43x4bSitgm6AR+p1uJxTZy0Uf3/CDT7TQy6sEAUPJBVKY8r4lR17TtGQONMpHGN3+1IL
 zYmsQU/VlVAbVQuqfjs5xaa1xajiUP50oZ9NwC4YNaC6rUGMWS+MGWsJfa2RPC1RFBW9+ujmASr
 50e5L8oaWj5Jb/wP1JQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfX3gMVRJZjKOjN
 W/B/mmdzThegJsc1COU+L2gmKlM8HT2bgzmvnCprqYQuj2dFoBeXX2lIcwoDP/IJxSu+6R8z+dc
 6vpg0lArQAOdXBysm06bDzSLYeHjB+k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250007
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

VGhlc2UgdGVzdHMgcGFzcyBub3cgdGhhdCBIVlggaXMgbW9kZWxlZCBmb3Igc3lzdGVtIGVtdWxh
dGlvbi4KClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9z
cy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3Nz
LnF1YWxjb21tLmNvbT4KLS0tCiB0ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9hcmNoX3Rl
c3RzLnB5IHwgNyArKysrKysrCiB0ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9zeXN0ZXN0
cy5weSAgIHwgNiArKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKQoKZGlm
ZiAtLWdpdCBhL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X2FyY2hfdGVzdHMucHkgYi90
ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9hcmNoX3Rlc3RzLnB5CmluZGV4IDQwZjc2ZTI1
YWU2Li4yOGJmMmYwMmQzOSAxMDA3NTUKLS0tIGEvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rl
c3RfYXJjaF90ZXN0cy5weQorKysgYi90ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9hcmNo
X3Rlc3RzLnB5CkBAIC0xMTksNiArMTE5LDEzIEBAIGRlZiB0ZXN0X3VzZXJfbW9kZShzZWxmKSAt
PiBOb25lOgogICAgICAgICAiIiIKICAgICAgICAgc2VsZi5ydW5fdWFydF90ZXN0KCJ0ZXN0X3Vz
ZXJfbW9kZSIpCiAKKyAgICBkZWYgdGVzdF9odnhfY29udGV4dChzZWxmKSAtPiBOb25lOgorICAg
ICAgICAiIiJUZXN0cyB0aGUgSFZYIGNvcHJvY2Vzc29yIGNvbnRleHQ6IFNTUiBYQSBjb250ZXh0
IHNlbGVjdGlvbgorICAgICAgICBhbmQgaXNvbGF0aW9uLCB2c3BsYXQvc3RvcmUsIGFuZCB0aGUg
Tk9fQ09QUk9DX0VOQUJMRSBleGNlcHRpb24KKyAgICAgICAgcmFpc2VkIHdoZW4gU1NSOlhFIGlz
IGNsZWFyLgorICAgICAgICAiIiIKKyAgICAgICAgc2VsZi5ydW5fdWFydF90ZXN0KCJ0ZXN0X2h2
eF9jb250ZXh0IikKKwogCiBpZiBfX25hbWVfXyA9PSAiX19tYWluX18iOgogICAgIFFlbXVTeXN0
ZW1UZXN0Lm1haW4oKQpkaWZmIC0tZ2l0IGEvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3Rf
c3lzdGVzdHMucHkgYi90ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9zeXN0ZXN0cy5weQpp
bmRleCAyNzc5ZWZhOTE3Mi4uYzgxMzdhNzE3MTMgMTAwNzU1Ci0tLSBhL3Rlc3RzL2Z1bmN0aW9u
YWwvaGV4YWdvbi90ZXN0X3N5c3Rlc3RzLnB5CisrKyBiL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdv
bi90ZXN0X3N5c3Rlc3RzLnB5CkBAIC05OSw1ICs5OSwxMSBAQCBkZWYgdGVzdF9tbXVfbXVsdGlf
dGxiKHNlbGYpOgogICAgIGRlZiB0ZXN0X3RpbWVyX3JlZyhzZWxmKToKICAgICAgICAgc2VsZi5y
dW5fZXhpdF96ZXJvKCJ0aW1lcl9yZWciKQogCisgICAgZGVmIHRlc3RfaHZ4X211bHRpKHNlbGYp
OgorICAgICAgICBzZWxmLnJ1bl9leGl0X3plcm8oImh2eC1tdWx0aSIpCisKKyAgICBkZWYgdGVz
dF9zdGFuZGFsb25lX3ZlYyhzZWxmKToKKyAgICAgICAgc2VsZi5ydW5fZXhpdF96ZXJvKCJzdGFu
ZGFsb25lX3ZlYyIpCisKIGlmIF9fbmFtZV9fID09ICJfX21haW5fXyI6CiAgICAgUWVtdVN5c3Rl
bVRlc3QubWFpbigpCi0tIAoyLjM0LjEKCg==

