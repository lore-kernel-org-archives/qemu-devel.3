Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC172C44507
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 04:20:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wka2l-0002O4-UT; Fri, 17 Jul 2026 00:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wka2k-0002Nu-UR
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 00:19:22 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wka2j-0004mV-8C
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 00:19:22 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66H33rYb607324
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 04:19:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=+dUFmUzogOEJwt9WROYw+y
 ifQ8/k34Ik80mqGu5Cjgk=; b=h/krq3hCgbVYjDv+vkd+ugG2itdfgpi6Km76+Y
 Pwv5GbTSax+OMyOVsBCdgUIzOAVkz7s4VtNUjMzhbUtAKvpX2K+pQ4R9/x/wkKpX
 sYX7ZnhdShboBzpqXhmI4zpiFxNoeCp/LVEW1Dyiir53JEiGYusnWbwXcw0BiuqM
 OUFNYaQsD/EsC+GISLBPIqKmEG3ifh/BQWGNZBNMn795jGHjhKkYANoMEz/OjfFN
 /jrvSbmbK+LcEiQZPQLXjsQuzFauPS+1r2HiqTrZeg11yyExuRDx5wtiRTTKZFYH
 2uDH4c7qE5ectL/JkYqyujMJXC7KPqNkEEXemIQGKJk4nPpw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feu10ckm4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 04:19:19 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38e4758ab46so663515a91.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 21:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784261959; x=1784866759; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+dUFmUzogOEJwt9WROYw+yifQ8/k34Ik80mqGu5Cjgk=;
 b=PDFIduSSi8h3N7RlwrTUyV6cDn6lQj5k08V4ggqrFnCVobYhJIXlFX/DN6AkIrcuHp
 Y/36m6t96wRhGLr0xRksYknycoK1Jka98IhguWWXlL8Rvt9SFPP1II0GmAu0Yf1r75z+
 qtnotBN2fwfo4Vphrc54hYOnaHB+fWX8L6MgCoSspwTKbZlnrtHl0jNeBR3i0NeTbk1B
 Rw0S9jOGg2zyQKOX6/0KgwYKy0zccZTo/ZD0izrdjILaubYKUO+dwe14q7VLDotrS9Vq
 o85/pvpAnW3n9JaFePnZPtl/FNRSq2ku+lAR+xvwuEQ6nhUqpSB8Ds5SkUssu28wOn3v
 yUbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784261959; x=1784866759;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+dUFmUzogOEJwt9WROYw+yifQ8/k34Ik80mqGu5Cjgk=;
 b=om4wmqZoFgvKojwsHH9llScBdbMfYFSkbqBalsWb5wfeWVv/bqEOxRnXMRIDWTRqaD
 iRODarvlUNh9YIux3qWf7z5S4sm9dstCGRnpkEeQsmRCOrEZIKHbP2RIbcRRea4ykgK0
 9MU/4xbLqz6oHpRl68dIEWNNq0f654Ndbh1DdCNP4WDYd9nWGRcU/h2dRrqWSQPpyhrN
 j75nJw4ZXvOg35z5xA8UNpy2Kb/vchT+iSGE3DDyDXb9bfSbAcbEMC6lqkPYmFpUCm/4
 Bs6LFM/A3sc31r/gXUSd2BWkRRmt6cTyb4b8psK7Fu5FJOkECOjwYQ+A8QLfQQqf1Zs6
 /ezQ==
X-Gm-Message-State: AOJu0YyZoG+gVnoqIAyJ7Ao0FLkLL5ZvLdGCxHIBe7JbP46uwU4pjJ8v
 6GJ1QeoNnX+a39rwDkYzJrWnAYkSQN9xgNHzeb61SBIFA5HQD5KislHay1s07mCip2HtRwUYQp2
 sKltaUvalLUP6hW7xQSXZJ0hSg8De67Otvsog//2WjOZXjukgdrFTG0PrY8At511iPg==
X-Gm-Gg: AfdE7cnGEsZlNo3ixaI8CuMeClgzK4JrTKayH/gg9QfpiwIgkRoCudgkpUeUQC5PesV
 faV1HEubSbM9/wfj2xyDlSv5zvrB2Za/CutnfDfwG49sUJz0eVFyKAVL5r1E+mxGpfFFuJFFpbx
 +thnouGOt813Xh/pxOloCQ5GRTcYCj+ylgC4+YQcw5WgPHUBAQkSLr3aHy5eaEBGCcB/lg8rMUs
 1m7I4qksNPSjaXs2HKcf60gFwXfYNSh0Ne7zJmC+WUPzt4hI7B0SYsvxoDU4ony2tudxa89Af9z
 phC0GYtX3a4ujZwaHXOCnHSp5jAC0XdiqKrc65/tTjqf1FBvoXQdyKu6eIkkOYAubM7lbfNMZXz
 F1lvvU+xr0Nizt8B/MWOO1UqDyUq4GBaViqJV6Whw0QtcEA1O
X-Received: by 2002:a17:90b:384c:b0:37f:464d:ea38 with SMTP id
 98e67ed59e1d1-38e4b240519mr862052a91.0.1784261958593; 
 Thu, 16 Jul 2026 21:19:18 -0700 (PDT)
X-Received: by 2002:a17:90b:384c:b0:37f:464d:ea38 with SMTP id
 98e67ed59e1d1-38e4b240519mr862026a91.0.1784261958162; 
 Thu, 16 Jul 2026 21:19:18 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31429f9bb62sm1888655eec.2.2026.07.16.21.19.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 21:19:17 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 matheus.bernardino@oss.qualcomm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH] gitlab-ci: build hexagon-softmmu to enable functional test
Date: Thu, 16 Jul 2026 21:19:16 -0700
Message-Id: <20260717041916.3949105-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: awXN-l-c98DIMr1e0KXGtwxtNu9q8-Ol
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDAzNyBTYWx0ZWRfX51HK5/B+wzGp
 eecjtmXacKSpsoSoHDHdJj5ZDAv7GPKlgvdYh370YWYtBGYgIo9ZtCTB+e7mC0CmPdlgnlNylel
 NR9QfZyKwmcGYu+sFrqfviFZJcvKiPZS0Pj3zhVVf/PaPTfF9FSn6avbgO64ZPfg0zZYRd8zKz/
 At8A+fm6sxREUS2c0lyFpxck2G7Z0jNVXWenZ0YLkA3S52UVxOdorxbRF2gDHUnUmNNNV5gUcnt
 n41QFZnkP9QYcF9f7OQ4YX768iTysbFpDZjB+O5nqvzNyhFSAMIF422sFMw9HX5ZsELl16SicLs
 U3AfkAbNYmJdX2eJebb9lOmXT6UFs83c7n5dEmY6XlicgT1Mbr68IKA+HL4UAbFigC5zwHnSQ1x
 23O2mMK63t2ELA9GLSNf1KwXNjTCb1Ww0K2Y9GGMfn5yzPqzDWqp9RowBG92RjDDboGD//CSk6X
 pWY1nhQYY4QseJ3Ykeg==
X-Proofpoint-GUID: awXN-l-c98DIMr1e0KXGtwxtNu9q8-Ol
X-Authority-Analysis: v=2.4 cv=BPODalQG c=1 sm=1 tr=0 ts=6a59ad47 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=xlymKiSa19zeW5sBXz8A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDAzNyBTYWx0ZWRfX9BrshRjSiSg4
 RV3S5sRdJTViIWtToWVwXhhip/zY4ylMn3RqtecMUTLT3Ew5mf0U9FvjgUzFNGZeDKIKZWpsCDe
 6ZJVbIxbjyZ57KQMEKzn8vEwARG2Qzw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_01,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170037
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

QWRkIGhleGFnb24tc29mdG1tdSB0byBidWlsZC1zeXN0ZW0tZGViaWFuJ3MgdGFyZ2V0IGxpc3Qg
c28gdGhhdCB0aGUKZXhpc3RpbmcgZnVuY3Rpb25hbC1zeXN0ZW0tZGViaWFuIGpvYiBwaWNrcyB1
cCBoZXhhZ29uIGZ1bmN0aW9uYWwKdGVzdC4KClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJy
aWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiAuZ2l0bGFiLWNpLmQvYnVpbGR0ZXN0Lnlt
bCB8IDQgKystLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS8uZ2l0bGFiLWNpLmQvYnVpbGR0ZXN0LnltbCBiLy5naXRsYWItY2ku
ZC9idWlsZHRlc3QueW1sCmluZGV4IGUyNTUzZTczMjZmLi44MzFkOWEyNjc0MiAxMDA2NDQKLS0t
IGEvLmdpdGxhYi1jaS5kL2J1aWxkdGVzdC55bWwKKysrIGIvLmdpdGxhYi1jaS5kL2J1aWxkdGVz
dC55bWwKQEAgLTcwLDggKzcwLDggQEAgYnVpbGQtc3lzdGVtLWRlYmlhbjoKICAgdmFyaWFibGVz
OgogICAgIElNQUdFOiBkZWJpYW4KICAgICBDT05GSUdVUkVfQVJHUzogLS13aXRoLWNvcm91dGlu
ZT1zaWdhbHRzdGFjayAtLWVuYWJsZS1ydXN0Ci0gICAgVEFSR0VUUzogYXJtLXNvZnRtbXUgaTM4
Ni1zb2Z0bW11IHJpc2N2NjQtc29mdG1tdSBzaDRlYi1zb2Z0bW11Ci0gICAgICBzcGFyYy1zb2Z0
bW11IHh0ZW5zYS1zb2Z0bW11CisgICAgVEFSR0VUUzogYXJtLXNvZnRtbXUgaGV4YWdvbi1zb2Z0
bW11IGkzODYtc29mdG1tdSByaXNjdjY0LXNvZnRtbXUKKyAgICAgIHNoNGViLXNvZnRtbXUgc3Bh
cmMtc29mdG1tdSB4dGVuc2Etc29mdG1tdQogICAgIE1BS0VfQ0hFQ0tfQVJHUzogY2hlY2stYnVp
bGQKIAogY2hlY2stc3lzdGVtLWRlYmlhbjoKLS0gCjIuMzQuMQoK

