Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D96D4CCA46C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 14:31:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHiwx-0004nT-G5; Fri, 16 Oct 2026 10:30:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xHiwv-0004mr-2n
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:30:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xHiwt-0007eR-7z
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:30:20 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE5oW32153791
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 14:30:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8knKJBhj3CLwKwN6vF7qBkMxkEJddyI8exnFWWUW0Y4=; b=fJPgfenK3KO+U114
 cu9M7qg1iFuCPETelCrKpLgTEq9cA5+BSZe0mHvXROfZ/2YKwP5qJsXhnIJGoR06
 piXxOfc2RZ+683sUGUx/mVmLIRg/Td5X5dqelb614y+hXtv/uISvlCAEep6yTCLV
 rsISnel6sDEGDI/LRh5vhmYirQEhtGriQQXg0fQyxiADj7CNFPBL2bPlDnN3bGzT
 j35n4maQeEdwKgSCUfz3E8O0ywRESA0My8Pc9nYgpyoIkpt1AmLlURYMqC8CihI1
 nrflbHzoHlBaM88MIBzBfIKtwaUBibkL+7UjBSthUWX9ZC/apKotzuvPlnwKjEZd
 AmfJqQ==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbhumrwa6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 14:30:17 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5da613f7588so7399458e0c.2
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 07:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792161017; x=1792765817; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8knKJBhj3CLwKwN6vF7qBkMxkEJddyI8exnFWWUW0Y4=;
 b=TCryi0Y1ON4Xft+/sekw234ex/lGfUqCyn+a0Iw++QttKgtoiIrasTqHaWbeQQxAM5
 I1Vew+ZiePDkIBmXI+ewzw3/wdxbBE9AOiNpzpLvwq9MVBE0CnNRUCkAvjuMN0dzExJR
 6hU067Ezxrvm+AFyhemcoiJc+YvE0urzjvdmUmADMDoL7VKYdR2GR+nwC59a55fMMKUd
 UXWdU4YKNqmYZceIeRtLmItNkBUj3KqXMB4H1knQfhiMOzdrM4yieEMij1ZqTv/ywh/H
 QOJfzpUgErvw29HLJhclk7ygIJqUg3kNeaGNnw9iWbQUJd3DvPHrlhvHC5NZ+oB4VW7C
 9CrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792161017; x=1792765817;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8knKJBhj3CLwKwN6vF7qBkMxkEJddyI8exnFWWUW0Y4=;
 b=KpIMRLTA7AUnS0V1L4AxTQGwPOPnDhuBq8i2m92wMK1qpur0vtZp9TfE6koOB+3Pzv
 oPQuIEzx30e1OxCHI5joenOiv2kI1g2J0iCzggEA0AKdPqHdOp+M+GMtLjDPj2TnnCFS
 E4ruhcjOgg3zljjSBY6mb2hxIoYKVjDFVZ44IVXn5dl4nT9O2fk5YoRLYyE01zRb/tb3
 FVycV86wEkwvQbInfuJ6J7gnPO1OrPN2ZiagJd9T3pHsAmxt/UxcmJhYDuK6o8kSCam6
 tK7PTvvH+Wgnl3qEQvSBls1WeGq5NugFQ+XGywSMtRGjcbIVponNSILtP9nG9/ek7kfs
 nleA==
X-Gm-Message-State: AFq9FYJXLlt8Xsv6nNaYfKnHZq2VKe7q8SpEYh1g0qBH1p37R3Gd1kd7
 xKOWIomeHPLLSqakSv6okc3U4n1nm/0HeUJUg8um2lSSHw+InAh3surTam7ver8wzZu2F//CSY/
 NXK0dNBlczKSAxRodQElR/CY5IPQHpLV/P76vUIpMYVDgCsm6LQ3UJStqRXeDhDtrVw==
X-Gm-Gg: AYBFou3uXVL3duFy2Y3/L8+8SddwTbgjRQaLpYDrEBcpaOD7uFr1dGPZoyk34RtY9rO
 6jDH3FOWBX5fd0qTr0//SJyrDlFML8rSzpjyCCoVrngQffweaX4lTtyeziVhHXaAYB6IdkmrKNI
 VuAsglKcCbDVpOF4sBoJ/s7tsGciTRoS+skRIUvxAnMyTFMvyxmvanIpunjrtc68AFwmbRM8ZT9
 l+2UMX6HG2bONpm97nMAnlsTa7JnBDO2f4fxo58qP+1K41BhWc0SjY6kMJ2INGsRwAfXEJzMq5A
 rElbSOFOa1KwZGjrCxiHeF2ZghvqgFy+AZNTqbtjqIihYWugfZMV74jCgG5CHygWYAlT5jxQSo6
 kleZU82WloSlcdMFVEMLPArE0AawmFnfwEEIMHFUvCDX90is=
X-Received: by 2002:a05:6122:54b:b0:5ea:a427:fdc with SMTP id
 71dfb90a1353d-5eaaa0f99bamr117913e0c.3.1792161015370; 
 Fri, 16 Oct 2026 07:30:15 -0700 (PDT)
X-Received: by 2002:a05:6122:54b:b0:5ea:a427:fdc with SMTP id
 71dfb90a1353d-5eaaa0f99bamr117829e0c.3.1792161013406; 
 Fri, 16 Oct 2026 07:30:13 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5ea9b474b2asm1605214e0c.4.2026.10.16.07.30.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 07:30:12 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 peter.maydell@linaro.org, Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v4 2/4] target/hexagon: fix semihosting OPEN filename handling
Date: Fri, 16 Oct 2026 07:30:05 -0700
Message-Id: <20261016143007.3474704-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261016143007.3474704-1-brian.cain@oss.qualcomm.com>
References: <20261016143007.3474704-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA1NyBTYWx0ZWRfX08eYd3n5vE23
 XSpgL/I5IT2n1mU0Ci6GqKA9YHjm4LIBiJ/V8WHNoEa/SxjhujQMSdEhUCAipaWbHv2qghmbVd6
 xzafYgGBwUSKus+Fn1FsxET/0H7Vd1A=
X-Authority-Analysis: v=2.4 cv=H+BOUOYi c=1 sm=1 tr=0 ts=6ad234f9 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=ykWGg2PKCrmQVCz4z_YA:9 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: J74IiMcNse2kQz-jB7U24J6T0g8Xk9c3
X-Proofpoint-ORIG-GUID: J74IiMcNse2kQz-jB7U24J6T0g8Xk9c3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA1NyBTYWx0ZWRfX2z1KKP2H5DlH
 UfTpon0Ee2d+mQ82vvNKuaRZMDlaKtaa8/42ZNw8la8HzNJI0TDGdwVJ/ef6ojNMmC/rmpwmDgI
 vrFxU4rZbc/Zj0VTJMxHIJhN2nDWDBqwTl2WIonA+P69DM+XxCqnKukraz55AeiCIzNCTd0NDJw
 +HcSHdDXtdGnsV4F8uSLhD+RpMGSGaJDLrJmIdBa75i1iqMINH5DUyyGwW0Lm4y1MvbOMjdxShQ
 xo+k0PdYN1kwnsqFSAqGkvRSRWhZBGH9ZLVZiIrFzCGa/UJwZ+UtmGY2lA4KiLbgcu1C3KGTsCl
 U76qB3xgeY5uY9jlUdpL+qthHUyPaBAqfbjqYh1UNBzHr0Fp2NCCmu4rXpcQVZeistUuFqpVrLm
 rAAxQ9IbbDBWEUEDIq0aF0D2bKlEaplB9r2lXFyYicdHkGUrxhuFqjBzqHI+ST7kGWY52uFXJQG
 0IrAanHX5zd18GCBngw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160057
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

SEVYX1NZU19PUEVOIGNvcGllZCBndWVzdCBieXRlcyBpbnRvIGEgZml4ZWQtc2l6ZSBidWZmZXIg
dW50aWwgaXQgZm91bmQgYQpOVUwuIEEgbWlzc2luZyB0ZXJtaW5hdG9yIGNvdWxkIG92ZXJydW4g
dGhhdCBidWZmZXIuIFVzZSBsb2NrX3VzZXIoKSB3aXRoCnRoZSBBQkkgZmlsZW5hbWUgbGVuZ3Ro
IGFuZCB2YWxpZGF0ZSBpdHMgdGVybWluYXRpbmcgTlVMIGJlZm9yZSBvcGVuaW5nIGl0LgoKRml4
ZXM6IDc3MTFmZGJhODhiICgidGFyZ2V0L2hleGFnb246IGFkZCBtYWluIGFyY2gtc3BlY2lmaWMg
c2VtaWhvc3Rpbmcgb3BlcmF0aW9ucyIpCkxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2Fs
bC9DQUZFQWNBOU1PczZWZkhmMlVIWjh6NGNkdmFCKzdEWTZoSmIyZW1ZWjJhTFNlLXQ2aXdAbWFp
bC5nbWFpbC5jb20vClN1Z2dlc3RlZC1ieTogUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBs
aW5hcm8ub3JnPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFs
Y29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vaGV4c3dpLmMgfCAyOSArKysrKysrKysrKyst
LS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDE3IGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2hleHN3aS5jIGIvdGFyZ2V0
L2hleGFnb24vaGV4c3dpLmMKaW5kZXggYmM4MDk1OTQzMzUuLmNjNDhjOWJhOWYxIDEwMDY0NAot
LS0gYS90YXJnZXQvaGV4YWdvbi9oZXhzd2kuYworKysgYi90YXJnZXQvaGV4YWdvbi9oZXhzd2ku
YwpAQCAtNDY5LDM1ICs0NjksMjkgQEAgc3RhdGljIHZvaWQgc2ltX2hhbmRsZV90cmFwMChDUFVI
ZXhhZ29uU3RhdGUgKmVudikKIAogICAgIGNhc2UgSEVYX1NZU19PUEVOOgogICAgIHsKLSAgICAg
ICAgY2hhciBmaWxlbmFtZVtCVUZTSVpdOworICAgICAgICBjaGFyICpmaWxlbmFtZTsKICAgICAg
ICAgdGFyZ2V0X3Vsb25nIHBoeXNpY2FsX2ZpbGVuYW1lX2FkZHI7CiAgICAgICAgIHVuc2lnbmVk
IGludCBmaWxlbW9kZTsKLSAgICAgICAgdWludDMyX3QgbGVuZ3RoOworICAgICAgICB1aW50MzJf
dCBmaWxlbmFtZV9sZW47CisgICAgICAgIHNpemVfdCBmaWxlbmFtZV9zaXplOwogICAgICAgICBp
bnQgcmVhbF9vcGVubW9kZTsKICAgICAgICAgaW50IHJldCwgZXJyID0gMDsKLSAgICAgICAgaW50
IGkgPSAwOwogCiAgICAgICAgIGlmIChnZXRfdXNlcl91MzIocGh5c2ljYWxfZmlsZW5hbWVfYWRk
ciwgc3dpX2luZm8pIHx8CiAgICAgICAgICAgICBnZXRfdXNlcl91MzIoZmlsZW1vZGUsIHN3aV9p
bmZvICsgNCkgfHwKLSAgICAgICAgICAgIGdldF91c2VyX3UzMihsZW5ndGgsIHN3aV9pbmZvICsg
OCkpIHsKKyAgICAgICAgICAgIGdldF91c2VyX3UzMihmaWxlbmFtZV9sZW4sIHN3aV9pbmZvICsg
OCkpIHsKICAgICAgICAgICAgIGdvdG8gZG9fZmF1bHQ7CiAgICAgICAgIH0KIAotICAgICAgICBp
ZiAobGVuZ3RoID49IEJVRlNJWikgewotICAgICAgICAgICAgcWVtdV9sb2dfbWFzayhMT0dfR1VF
U1RfRVJST1IsCi0gICAgICAgICAgICAgICAgICAgICAgICAgICIlczogZmlsZW5hbWUgdG9vIGxh
cmdlICglIiBQUkl1MzIgIilcbiIsCi0gICAgICAgICAgICAgICAgICAgICAgICAgIF9fZnVuY19f
LCBsZW5ndGgpOwotICAgICAgICAgICAgc2VtaV9jYihjcywgLTEsIEVOQU1FVE9PTE9ORyk7Ci0g
ICAgICAgICAgICBicmVhazsKKyAgICAgICAgLyogVGhlIEFCSSBsZW5ndGggZXhjbHVkZXMgdGhl
IGZpbGVuYW1lJ3MgdGVybWluYXRpbmcgTlVMLiAqLworICAgICAgICBmaWxlbmFtZV9zaXplID0g
KHNpemVfdClmaWxlbmFtZV9sZW4gKyAxOworICAgICAgICBmaWxlbmFtZSA9IGxvY2tfdXNlcihW
RVJJRllfUkVBRCwgcGh5c2ljYWxfZmlsZW5hbWVfYWRkciwKKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgZmlsZW5hbWVfc2l6ZSwgdHJ1ZSk7CisgICAgICAgIGlmICghZmlsZW5hbWUgfHwg
ZmlsZW5hbWVbZmlsZW5hbWVfbGVuXSAhPSAnXDAnKSB7CisgICAgICAgICAgICB1bmxvY2tfdXNl
cihmaWxlbmFtZSwgcGh5c2ljYWxfZmlsZW5hbWVfYWRkciwgMCk7CisgICAgICAgICAgICBnb3Rv
IGRvX2ZhdWx0OwogICAgICAgICB9CiAKLSAgICAgICAgZG8gewotICAgICAgICAgICAgaWYgKGdl
dF91c2VyX3U4KGZpbGVuYW1lW2ldLCBwaHlzaWNhbF9maWxlbmFtZV9hZGRyICsgaSkpIHsKLSAg
ICAgICAgICAgICAgICBnb3RvIGRvX2ZhdWx0OwotICAgICAgICAgICAgfQotICAgICAgICAgICAg
aSsrOwotICAgICAgICB9IHdoaWxlIChmaWxlbmFtZVtpIC0gMV0pOwotCiAgICAgICAgIC8qIGNv
bnZlcnQgQVJNIEFOR0VMIGZpbGVtb2RlIGludG8gaG9zdCBmaWxlbW9kZSAqLwogICAgICAgICBp
ZiAoZmlsZW1vZGUgPCBBUlJBWV9TSVpFKGFuZ2VsX3RvX2hvc3RfZmlsZW1vZGVfdGFibGUpKSB7
CiAgICAgICAgICAgICByZWFsX29wZW5tb2RlID0gYW5nZWxfdG9faG9zdF9maWxlbW9kZV90YWJs
ZVtmaWxlbW9kZV07CkBAIC01MDUsNiArNDk5LDcgQEAgc3RhdGljIHZvaWQgc2ltX2hhbmRsZV90
cmFwMChDUFVIZXhhZ29uU3RhdGUgKmVudikKICAgICAgICAgICAgIHFlbXVfbG9nX21hc2soTE9H
X0dVRVNUX0VSUk9SLAogICAgICAgICAgICAgICAgICAgICAgICAgICAiJXM6IGludmFsaWQgT1BF
TiBtb2RlOiAldVxuIiwKICAgICAgICAgICAgICAgICAgICAgICAgICAgX19mdW5jX18sIGZpbGVt
b2RlKTsKKyAgICAgICAgICAgIHVubG9ja191c2VyKGZpbGVuYW1lLCBwaHlzaWNhbF9maWxlbmFt
ZV9hZGRyLCAwKTsKICAgICAgICAgICAgIHNlbWlfY2IoY3MsIC0xLCBFSU5WQUwpOwogICAgICAg
ICAgICAgYnJlYWs7CiAgICAgICAgIH0KLS0gCjIuMzQuMQoK

