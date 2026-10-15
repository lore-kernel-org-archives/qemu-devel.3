Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30408CC6B38
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 20:04:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHRg0-0003Wq-5B; Thu, 15 Oct 2026 16:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xHRfw-0003QP-RN
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 16:03:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xHRfu-0003FE-Pt
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 16:03:40 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FFHNM52999177
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 20:03:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +wdQOWWjrb2A+1zKjaniSXLm1/gTrVOZcbWWQj2p5Vs=; b=AdzuJZZ/4n0+8JE0
 a0ECcTAoUkIv7Vsy4Nbj0lpXa+fQi0+jBCYX4AjzbrrJ4W2Xr5otg/bxkGqWn3TS
 /BW6PryqsJy1ekl2FRgZPvE4XHpUprKJg+3TnDVJi5MXHQgQUkpueyc/9B1dIKWD
 piizDQyh9L7jPQA+MTvs71ZMYRVrIDlcg3SXAzLHvAk3UlbsyxDNVsCqRzTg2AOe
 1zkM8O3cPlJVNnHXdRINWCy+uNQz70OtdMQ/uQV5GCjmknrTNEY9C9VEQVgUpPjf
 wCI306DhGwFCbQyBZZFK3NWsfS+oPld6VtVq8zfEaaGFG+mtQ6FWW8N9aCXi/duG
 5ZzoeA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hausm2qck-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 20:03:37 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-35a4d2e39acso4425263eec.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 13:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792094616; x=1792699416; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+wdQOWWjrb2A+1zKjaniSXLm1/gTrVOZcbWWQj2p5Vs=;
 b=RgKBi99z816PEp/x7tsbB/pyk6diQ8f5oWyBiTs74CdlGre5Jn6sH4dQFSnMr9F6E8
 6ZHgEEMbf/HvhrIDXenjnJL8AE2wi5lKf46NGvkTijfqwvTxRchjKLFa2AQd/+uwC+0V
 8SKgVkL9+FzMuG8z8wHAlIUwk4IV9TIHDStqN8vNn44OliMuq9i1JKdCYNgHUL1KAnge
 5FC/+38GUx4SzqMBTqlrGISSFymqVeVN8wkYNRRg+0Bx5srWrK0nh8l4BgHVOmIRCaxE
 HnF3qvijAwskUIxbMIoMG3gXUXRpPOomJgyyNB9nmxqngLx/nNRLgy85WBhNkq0mNbR5
 zxWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792094616; x=1792699416;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+wdQOWWjrb2A+1zKjaniSXLm1/gTrVOZcbWWQj2p5Vs=;
 b=KTkL2ZC55gsu5Z8sB5mklU3wc7lbfboG543wy/xaulisI7GVb0Wp88exXT9D93DhEo
 qZTUuNaEDX0osr5FTtABptOADuuHTG75yy7n+kHDXq7Ar8LvlIrd7DyJ2yrXN7OpytJw
 d3JeHnm55VVe0WgnmoChoIPJAGTKDjKzOzGYthbjQynO89dm1vFbQOUPCssUsO2bq1zn
 VgewHicz3EY37OeSkgUgMHV+SrijZRWQRy1qnVKUjvptglSOqopsV3lkqHlhi7xJH1S/
 5vWLfFhtwY8oZhEfQJLJHk3DJJsDX0LfvHRinSQS6J4lBrLWQkhgSWhVfWe+VznkyQya
 XEqw==
X-Gm-Message-State: AFq9FYKR1BrEAXCw+TiSdsyBFjpaVA/LiD/E0cBCuGNdbtFXtMuj3rgc
 RrRm+QDT0mfX6GfNBPwe1KHgXIHU9AKTpC/kO/hmzYE0FCwFxGyw7E4yM6EP8ZTp59tu8OJOegC
 neCmSb987NYzP2wuZCjkeVuByYtnskU3RkYvu5mtBkaDd9QKW3Glyd31ySiOC9FB7LQ==
X-Gm-Gg: AYBFou1w2ScYseFfoPnupubA8d5Z/6PZaBskt4TGkQjzf4qEacGq0gsNBhkxQdoB4oA
 WCZSsCGMVuY4WodWDNXM/dsrIUyE9E+0gFtYYhCrotw25wqWm42XoL1//W6WJu1MGMuY2e6MjwC
 hipTQhAmeDYCQ+C3TzUd3H+gqY1fqmA2J3u49+QZDPYw3r1cPZfwk1qw0Q4USgm6Vsc5AmLp0I+
 uCQDO2mDhZLNIuyQOeSrbioYwZA9KYh80lQeH8YgBG5jfTUPZJPJgTMg0iYYXZP9EzIf4ED3jWL
 dKw+jUBXDCF020Te0tljthx63wFy7VHeHGmfJY75kbIR4GTxC0kCusg2m5dyNJZUesFHpvqhudW
 7+Q2IVx3Mc7dNOzSEvYmr5Cv2Xc4EO9dSAUMXf7SlxUk39lU=
X-Received: by 2002:a05:701b:4194:10b0:17f:84cd:6f81 with SMTP id
 a92af1059eb24-17f84cd7132mr6191744c88.12.1792094616488; 
 Thu, 15 Oct 2026 13:03:36 -0700 (PDT)
X-Received: by 2002:a05:701b:4194:10b0:17f:84cd:6f81 with SMTP id
 a92af1059eb24-17f84cd7132mr6191706c88.12.1792094615716; 
 Thu, 15 Oct 2026 13:03:35 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-182a6d6969asm1347058c88.12.2026.10.15.13.03.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 13:03:34 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 9/9] tests/functional/hexagon: add MiniVM, lock tests
Date: Thu, 15 Oct 2026 13:03:06 -0700
Message-Id: <20261015200306.1602540-10-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261015200306.1602540-1-brian.cain@oss.qualcomm.com>
References: <20261015200306.1602540-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: U9hEohXeUlt-qogu49je-5v_bUbFyw03
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA3OSBTYWx0ZWRfX8ZVQFly+tiQg
 KSPiN/nH1N2Ly8D9wX9QxpmONyEqfgraDspgiIwihLXCMbnY/AqJ+yyLq/tNZDYoTXGcuWke4Jm
 TRqJfrNraM0pRNk4jwY0XeezAooPTqtFFGsJQhmAL/WJGFRU4QrWbr2H+io/bGgaLWpGDAK677a
 L/LFTasEF/2KhECBdwJNy8yDYF5t/kVGeD/wCUTc5PW7OWQ20ZwtWNRdk7v/+NILXLWfad/Z9ni
 1YzLTCdC+ZchfY9OV/ZDbn4NUv4cwgqpTQdkWNgf3C0L3ByGJf/snL6tTZjnD8Uvbo+j7bZIf8n
 WUdKEQCdj60wlc65+iXP3p/WgXKT50ayy54n0AJRR9nHE9D2Ji5l1E/a+eXjOZSWdhzDZ/SEPGp
 5QyB31Dz+fbzBTPLMXm0Nbx88PpSuleQUKcxGawbh8h4QEtw3rNT64DqD3Yvly4bBgVsMMFt4pC
 CV5WmXVlFXeSXVwwFoQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA3OSBTYWx0ZWRfX7az7f2oev7rg
 F55Lw+f1RrXIQSgKr7f9jjnghetEDUqo9ziJXIs7E7DIKXPpBlHMHOd3JPIBiKBg/7xI2jujqXk
 pDglb/5OHC0NC54FvwZfh6qCniVWV8o=
X-Authority-Analysis: v=2.4 cv=Eb5d0/mC c=1 sm=1 tr=0 ts=6ad13199 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=5vFef2XoAAAA:20 a=EUspDBNiAAAA:8 a=N306dsr3tXGB1petHgEA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: U9hEohXeUlt-qogu49je-5v_bUbFyw03
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150079
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

QWRkIHRoZSBsb2NrX3ZlcmlmeSB0ZXN0IGNhc2UgdG8gdmVyaWZ5IHRoZSBrMC90bGJsb2NrIGJl
aGF2aW9yLCBhZGQgdGhlCm1pbml2bSB0ZXN0cyB0byBjb3ZlciBzdGFydCgpIGFuZCBtb3JlLgoK
UmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxj
b21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNv
bW0uY29tPgotLS0KIHRlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi9tZXNvbi5idWlsZCAgICAgIHwg
IDEgKwogdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3RfbWluaXZtLnB5ICAgfCA0OCArKysr
KysrKysrKysrKysrKysrKysrKwogdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3Rfc3lzdGVz
dHMucHkgfCAgMyArKwogMyBmaWxlcyBjaGFuZ2VkLCA1MiBpbnNlcnRpb25zKCspCiBjcmVhdGUg
bW9kZSAxMDA3NTUgdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3RfbWluaXZtLnB5CgpkaWZm
IC0tZ2l0IGEvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL21lc29uLmJ1aWxkIGIvdGVzdHMvZnVu
Y3Rpb25hbC9oZXhhZ29uL21lc29uLmJ1aWxkCmluZGV4IDQ0MDUzZTY0Njc2Li5lMTgyYmM5OGEw
NiAxMDA2NDQKLS0tIGEvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL21lc29uLmJ1aWxkCisrKyBi
L3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi9tZXNvbi5idWlsZApAQCAtMyw2ICszLDcgQEAKIHRl
c3RzX2hleGFnb25fc3lzdGVtX3Rob3JvdWdoID0gWwogICAnYXJjaF90ZXN0cycsCiAgICdzeXN0
ZXN0cycsCisgICdtaW5pdm0nLAogXQogCiB0ZXN0X2hleGFnb25fdGltZW91dHMgPSB7CmRpZmYg
LS1naXQgYS90ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9taW5pdm0ucHkgYi90ZXN0cy9m
dW5jdGlvbmFsL2hleGFnb24vdGVzdF9taW5pdm0ucHkKbmV3IGZpbGUgbW9kZSAxMDA3NTUKaW5k
ZXggMDAwMDAwMDAwMDAuLjExNWYzY2YzNzEwCi0tLSAvZGV2L251bGwKKysrIGIvdGVzdHMvZnVu
Y3Rpb25hbC9oZXhhZ29uL3Rlc3RfbWluaXZtLnB5CkBAIC0wLDAgKzEsNDggQEAKKyMhL3Vzci9i
aW4vZW52IHB5dGhvbjMKKyMKKyMgQ29weXJpZ2h0KGMpIDIwMjQtMjAyNSBRdWFsY29tbSBJbm5v
dmF0aW9uIENlbnRlciwgSW5jLiBBbGwgUmlnaHRzIFJlc2VydmVkLgorIworIyBTUERYLUxpY2Vu
c2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcgorCitmcm9tIHFlbXVfdGVzdCBpbXBvcnQg
UWVtdVN5c3RlbVRlc3QsIEFzc2V0CisKK2NsYXNzIE1pbmlWTVRlc3QoUWVtdVN5c3RlbVRlc3Qp
OgorICAgICcnJworICAgIG1pbml2bSBpcyBhIEhleGFnb24gaHlwZXJ2aXNvciB0aGF0IGltcGxl
bWVudHMgdGhlIEhleGFnb24gVk0KKyAgICBzcGVjaWZpY2F0aW9uLiAgVGhlc2UgdGVzdCBjYXNl
cyBib290IG1pbml2bSBhbmQgdGhlbiBsb2FkIHRlc3QgY2FzZXMKKyAgICB0byB0aGUgYWRkcmVz
cyBzcGVjaWZpZWQgYnkgTWluaVZNVGVzdC5HVUVTVF9FTlRSWSBhbmQKKyAgICBleGVjdXRlIGEg
bWludm0tZ3Vlc3QgcHJvZ3JhbSB0byBleGVyY2lzZSBtaW5pdm0gdmlydHVhbGl6YXRpb24KKyAg
ICBmZWF0dXJlcy4KKyAgICAnJycKKyAgICB0aW1lb3V0ID0gMTgwCisgICAgR1VFU1RfRU5UUlkg
PSAweGMwMDAwMDAwCisgICAgQVNTRVRfVEFSQkFMTCA9IEFzc2V0KAorICAgICAgICAnaHR0cHM6
Ly9naXRodWIuY29tL3F1YWxjb21tL3FlbXUtaGV4YWdvbi10ZXN0aW5nL3JlbGVhc2VzLycKKyAg
ICAgICAgJ2Rvd25sb2FkL3YwLjIuMjEvaGV4YWdvbl9taW5pdm0udGFyLmd6JywKKyAgICAgICAg
JzU5ODA3NDBjNWZhNTA1ZjU1Y2FjZDE2NDYwODg4MzEyMDJkZjRjY2JmOWUyZGRjMzRiNjkwNjcz
NTc0MTY5YmEnKQorCisgICAgZGVmIHJ1bl9taW5pdm1fdGVzdChzZWxmLCB0ZXN0X2Nhc2UpOgor
ICAgICAgICBzZWxmLnNldF9tYWNoaW5lKCdzaW0nKQorICAgICAgICBzZWxmLmFyY2hpdmVfZXh0
cmFjdChzZWxmLkFTU0VUX1RBUkJBTEwpCisgICAgICAgIHJvb3Rmc19wYXRoID0gc2VsZi5zY3Jh
dGNoX2ZpbGUoJ2hleGFnb24tdW5rbm93bi1saW51eC1tdXNsLXJvb3RmcycpCisgICAgICAgIGtl
cm5lbF9wYXRoID0gZid7cm9vdGZzX3BhdGh9L2Jvb3QvbWluaXZtJworCisgICAgICAgIHZtID0g
c2VsZi5nZXRfdm0obmFtZT10ZXN0X2Nhc2UpCisgICAgICAgIHZtLmFkZF9hcmdzKCcta2VybmVs
Jywga2VybmVsX3BhdGgsICctZGV2aWNlJywKKyAgICAgICAgICAgICAgICAgICAgZidsb2FkZXIs
YWRkcj17aGV4KHNlbGYuR1VFU1RfRU5UUlkpfSwnCisgICAgICAgICAgICAgICAgICAgIGYnZmls
ZT17cm9vdGZzX3BhdGh9L2Jvb3Qve3Rlc3RfY2FzZX0nKQorICAgICAgICB2bS5sYXVuY2goKQor
ICAgICAgICB2bS53YWl0KCkKKyAgICAgICAgc2VsZi5hc3NlcnRFcXVhbCh2bS5leGl0Y29kZSgp
LCAwKQorCisgICAgZGVmIHRlc3RfbW11KHNlbGYpOgorICAgICAgICBzZWxmLnJ1bl9taW5pdm1f
dGVzdCgndGVzdF9tbXUnKQorCisgICAgZGVmIHRlc3RfaW50ZXJydXB0cyhzZWxmKToKKyAgICAg
ICAgc2VsZi5ydW5fbWluaXZtX3Rlc3QoJ3Rlc3RfaW50ZXJydXB0cycpCisKKyAgICBkZWYgdGVz
dF9wcm9jZXNzb3JzKHNlbGYpOgorICAgICAgICBzZWxmLnJ1bl9taW5pdm1fdGVzdCgndGVzdF9w
cm9jZXNzb3JzJykKKworaWYgX19uYW1lX18gPT0gJ19fbWFpbl9fJzoKKyAgICBRZW11U3lzdGVt
VGVzdC5tYWluKCkKZGlmZiAtLWdpdCBhL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X3N5
c3Rlc3RzLnB5IGIvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3Rfc3lzdGVzdHMucHkKaW5k
ZXggMjBjNThmODRmNjcuLjA0ODlkYjBhZjkxIDEwMDc1NQotLS0gYS90ZXN0cy9mdW5jdGlvbmFs
L2hleGFnb24vdGVzdF9zeXN0ZXN0cy5weQorKysgYi90ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24v
dGVzdF9zeXN0ZXN0cy5weQpAQCAtMTA4LDUgKzEwOCw4IEBAIGRlZiB0ZXN0X2h2eF9tdWx0aShz
ZWxmKToKICAgICBkZWYgdGVzdF9zdGFuZGFsb25lX3ZlYyhzZWxmKToKICAgICAgICAgc2VsZi5y
dW5fZXhpdF96ZXJvKCJzdGFuZGFsb25lX3ZlYyIpCiAKKyAgICBkZWYgdGVzdF9sb2NrX3Zlcmlm
eShzZWxmKToKKyAgICAgICAgc2VsZi5ydW5fZXhpdF96ZXJvKCJsb2NrX3ZlcmlmeSIpCisKIGlm
IF9fbmFtZV9fID09ICJfX21haW5fXyI6CiAgICAgUWVtdVN5c3RlbVRlc3QubWFpbigpCi0tIAoy
LjM0LjEKCg==

