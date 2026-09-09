Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48070C79FB5
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 04:03:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x49VO-0006xK-Qa; Wed, 09 Sep 2026 00:01:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x49VN-0006wu-0Y
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 00:01:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x49VK-0003qG-Nw
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 00:01:48 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6892aD0L1189546
 for <qemu-devel@nongnu.org>; Wed, 9 Sep 2026 04:01:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4k1Ib2S8RJ8MvA4/q2+Kmb9rngoKzIoP7jCbMTAnu68=; b=L2DbB+lIRxTrPLrx
 HpMkR7LcpCYa6WomV9pn4/EWWvqegP2faXEw01RmBwcDoRJEvKq3qB0HvbytdIco
 bpuPW6KAPCn9+nRtq6W46md3oqnhwEx+KPWkECfUSOEV8A0BBXKn5lkKQIiU18Ms
 zOKblfKE97jxS80fdzteoypw0gwBsVr3Ptv62elPGMpMg3cbGRPHymAPB6vhcpv+
 jLM9CGqbi1WhsBpgNMEs6e1/SJ6eJJ668mzCpniw5kladaZ8B0UWUKj+DoZESP3S
 /SGYIeTslJJPZl6MXo/A4gbE2NjIhadwJSsQ2v4wuZDrJPK1f0L30267HYlE5cvn
 Y1VJ3g==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjxtm08ub-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 04:01:43 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-7e7624e584dso6769659a34.2
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 21:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788926502; x=1789531302; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4k1Ib2S8RJ8MvA4/q2+Kmb9rngoKzIoP7jCbMTAnu68=;
 b=YRsVqzeWjk/stO/+o65O9rk01kzMuVCjVlNKTmlUCPtfPeUqJdcmPvMZs6ZKz/hwiU
 LEopbQllNmm0y6nOuo0YBmVVjREIYOyolAsH+oZUkxVTbwczJuti3iDHLTBw9zhFygGP
 t/uSxzYYZsJBNnjv/8lNeXIViXfxGZYkVA0MnkBMEIvidPqeYogVSFkcVKkEgwCk2S1/
 5UtWRHnmQYZ1Kk/BMPqOVsqf/l7nX4kIBiDBbOh6ap4tbGxTxFRSEBK4vKXbRKr0hne5
 ZpyLPhzrBY/MvzmemFGjwk7N2B4x2y2qoRQgYUqFfYaQEMGbyzBq6ZbKL89w0edzjENz
 GJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788926502; x=1789531302;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4k1Ib2S8RJ8MvA4/q2+Kmb9rngoKzIoP7jCbMTAnu68=;
 b=F93Q5XRk/O9Pq8Qd0JccLN/MRuYWmIgRyDT5S8q8/3lrymjR7WYhufJxkHixxWA2QO
 lwaCFF+GOGHRRWaogbXQKfvhXaaupFpElheIXPuvUyuLmliJu1I26TV6AAvhhsWlhDyO
 5rbBAgtJ4/q7kN2EgDLR6ZPm+AyJwJ0URpzazJlZZZRN+W7gG1M4OTl07atFolY/KwJT
 5tMUfw310ApnQObyphcT34TEEUF6Azj4b0kp45IlOmrAU40bmIZyohsThVF3/Hmo2Oll
 r1vpVMy1XJSzcNhHDpc8qVgj2xOht0bHAvtu2iAjqr54yYWr0I8qoVctvf6zB+MSs/lA
 wcCw==
X-Gm-Message-State: AFuF++l4w5rxrCc2lgoCqmsRkVa57OkfLPiNqVLCxfIF3Fw1Q9NExf+l
 TcaddoXOff1hN2J2qkftSnIirJCXK1OZ94x/p03Nbilgt8A51SepHx8YN/vWV9IxqkMOvodbSp8
 6JdGXFa3EBD9CH4vnriTDW8YCFIM2M2FjW51+ym0HB9RdnYavvjDAAdxIK4T/Xzdw+A==
X-Gm-Gg: AYBFou2Tasf0/sBFJbfkqyGKa8DK4BB93a6NYurFcgZEfOuZS0OivhaNOK+YqzFQMuO
 p5D6AZ/LSo1DWzLraevnmYF2zgd3zdT3m77Lwn59maZ5srLsg+nQoaO9lRFxFd7mbSVvDZ8tjt8
 Ta60ZAA/8VhAwJhBfWCU/8ZCHeDPIBUDowLv6qKCVs0UlLvRcxI8O70ZofEoat/NKxl5klhbVoS
 x0Y/5m1rs3FuPh/44BiwMVdrsX+vfK6450BJMzZ1nOYIkxBfEVfGcOCZQfqvSVX3hYL7akCzEg2
 JzSnt7ME48JKPEoZPA2Dk+tK8CkUkPB3G8w+J7lkIDsueJFhDOgXA+ENWGHLrMHwtNROXRMNcbX
 O2O3cByf78ud42tUNXG+Gx0pr0hpPQYAL/Voqtt2+00LXI0FY
X-Received: by 2002:a05:6830:82b5:b0:7f4:e011:6b3f with SMTP id
 46e09a7af769-7fa2007dd6bmr26409365a34.14.1788926502345; 
 Tue, 08 Sep 2026 21:01:42 -0700 (PDT)
X-Received: by 2002:a05:6830:82b5:b0:7f4:e011:6b3f with SMTP id
 46e09a7af769-7fa2007dd6bmr26409314a34.14.1788926501939; 
 Tue, 08 Sep 2026 21:01:41 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-336c2571039sm20407002eec.25.2026.09.08.21.01.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 21:01:41 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: marco.liebel@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v2 1/9] target/hexagon: add the v75, v79 and v81 CPU models
Date: Tue,  8 Sep 2026 21:01:29 -0700
Message-Id: <20260909040137.3414132-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260909040137.3414132-1-brian.cain@oss.qualcomm.com>
References: <20260909040137.3414132-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDA0MyBTYWx0ZWRfXxUhRG+3rLoLD
 CO/zU3nx9WS0l5kgbms2F6PgsPDLvoSpAxix66OC8t31WuQJJ3V2QdTc2DUrvB+oUzud5fa8OB5
 HHHp9bPoi2KdqSK2ArnhOUD8oHFhX/g=
X-Proofpoint-GUID: RpvvCAvLCN2WEoxuvSnCNiGq23eOrvMT
X-Authority-Analysis: v=2.4 cv=F+1nsKhN c=1 sm=1 tr=0 ts=6aa0da27 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=sGg2OeOXg0vhTN0KIsEA:9 a=QEXdDO2ut3YA:10
 a=Z1Yy7GAxqfX1iEi80vsk:22
X-Proofpoint-ORIG-GUID: RpvvCAvLCN2WEoxuvSnCNiGq23eOrvMT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDA0MyBTYWx0ZWRfX5+rf+BwHo4mT
 TanKK25Xm/YHZXF2QmNmvoOBX4KOmL5zQy7mKX+YdHFD+yj22E3klfrAFxorB+C5pEm0M1FuizL
 QbVs8LK8nqYPbEGoBDF64ilpgX8d7EOmLqi9WDa0AEDI5SqH8GtSXZVXAWeAF6Zd9GH4NRLFidP
 g3vcDexmyRj5e1kvIvptAK8nqcz6A5WXMHIPshfG5CQD/Jkd3jmEgogL4Tb+rkPG1ZvKf48JYKc
 gGay2FxSPQb23xPOgulgQQ1Tx5wQ/W3a/HmV+VyTA6Ihr7eFdC1q4/L1x5LbBKURF3HhMqF7AMS
 mlqbhG26AahaZ7Ge53SWv7APOdRIpn1/e1dFtlsIFQk/H2MgnVO7M7anBpesyqBUAXz1LUA0ig3
 iUbS/UKcMyq8+pn1Ns+u94luX0+zUbzjTwEGvVOqULuBV//t/3coajZGI1QQMkvZlX4cwqbV2EP
 vbjCiYvmaFXBKEpSJWg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0 adultscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090043
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

djczIGlzIGN1cnJlbnRseSB0aGUgbmV3ZXN0IGNvcmUgdGhpcyB0YXJnZXQgaW1wbGVtZW50cy4K
CkFkZCB0aGUgdjc1LCB2NzksIHY4MSBDUFVzLiAgTmV3IGluc3RydWN0aW9ucyB0byBmb2xsb3cg
aW4gc3Vic2VxdWVudApjb21taXRzLgoKUmV2aWV3ZWQtYnk6IE1hcmNvIExpZWJlbCA8bWFyY28u
bGllYmVsQG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFu
LmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9jcHUtcW9tLmggICAg
IHwgNiArKysrKysKIGxpbnV4LXVzZXIvaGV4YWdvbi9lbGZsb2FkLmMgfCA2ICsrKysrKwogdGFy
Z2V0L2hleGFnb24vY3B1LmMgICAgICAgICB8IDMgKysrCiAzIGZpbGVzIGNoYW5nZWQsIDE1IGlu
c2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHUtcW9tLmggYi90YXJn
ZXQvaGV4YWdvbi9jcHUtcW9tLmgKaW5kZXggNmUxYmIwNDA3MDQuLjJiZmE0ZDVkMGZjIDEwMDY0
NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUtcW9tLmgKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1
LXFvbS5oCkBAIC0yNSw2ICsyNSw5IEBAIHR5cGVkZWYgZW51bSB7CiAgICAgSEVYX1ZFUl9WNjkg
PSAweDY5LAogICAgIEhFWF9WRVJfVjcxID0gMHg3MSwKICAgICBIRVhfVkVSX1Y3MyA9IDB4NzMs
CisgICAgSEVYX1ZFUl9WNzUgPSAweDc1LAorICAgIEhFWF9WRVJfVjc5ID0gMHg3OSwKKyAgICBI
RVhfVkVSX1Y4MSA9IDB4ODEsCiAgICAgSEVYX1ZFUl9BTlkgPSAweGZmLAogfSBIZXhhZ29uVmVy
c2lvbjsKIApAQCAtNDksNiArNTIsOSBAQCB0eXBlZGVmIHN0cnVjdCB7CiAjZGVmaW5lIFRZUEVf
SEVYQUdPTl9DUFVfVjY5IEhFWEFHT05fQ1BVX1RZUEVfTkFNRSgidjY5IikKICNkZWZpbmUgVFlQ
RV9IRVhBR09OX0NQVV9WNzEgSEVYQUdPTl9DUFVfVFlQRV9OQU1FKCJ2NzEiKQogI2RlZmluZSBU
WVBFX0hFWEFHT05fQ1BVX1Y3MyBIRVhBR09OX0NQVV9UWVBFX05BTUUoInY3MyIpCisjZGVmaW5l
IFRZUEVfSEVYQUdPTl9DUFVfVjc1IEhFWEFHT05fQ1BVX1RZUEVfTkFNRSgidjc1IikKKyNkZWZp
bmUgVFlQRV9IRVhBR09OX0NQVV9WNzkgSEVYQUdPTl9DUFVfVFlQRV9OQU1FKCJ2NzkiKQorI2Rl
ZmluZSBUWVBFX0hFWEFHT05fQ1BVX1Y4MSBIRVhBR09OX0NQVV9UWVBFX05BTUUoInY4MSIpCiAK
IE9CSkVDVF9ERUNMQVJFX0NQVV9UWVBFKEhleGFnb25DUFUsIEhleGFnb25DUFVDbGFzcywgSEVY
QUdPTl9DUFUpCiAKZGlmZiAtLWdpdCBhL2xpbnV4LXVzZXIvaGV4YWdvbi9lbGZsb2FkLmMgYi9s
aW51eC11c2VyL2hleGFnb24vZWxmbG9hZC5jCmluZGV4IDM5YjAyMDE4MTQ1Li4yZmQ0NWY3ZTM4
YSAxMDA2NDQKLS0tIGEvbGludXgtdXNlci9oZXhhZ29uL2VsZmxvYWQuYworKysgYi9saW51eC11
c2VyL2hleGFnb24vZWxmbG9hZC5jCkBAIC0zNyw2ICszNywxMiBAQCBjb25zdCBjaGFyICpnZXRf
ZWxmX2NwdV9tb2RlbCh1aW50MzJfdCBlZmxhZ3MpCiAgICAgICAgIHJldHVybiAidjcxIjsKICAg
ICBjYXNlIDB4NzM6CiAgICAgICAgIHJldHVybiAidjczIjsKKyAgICBjYXNlIDB4NzU6CisgICAg
ICAgIHJldHVybiAidjc1IjsKKyAgICBjYXNlIDB4Nzk6CisgICAgICAgIHJldHVybiAidjc5IjsK
KyAgICBjYXNlIDB4ODE6CisgICAgICAgIHJldHVybiAidjgxIjsKICAgICB9CiAKICAgICBlcnIg
PSBzbnByaW50ZihidWYsIHNpemVvZihidWYpLCAidW5rbm93biAoMHgleCkiLCBlZmxhZ3MpOwpk
aWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LmMgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwpp
bmRleCA0YTdiNzZlM2JjYy4uZmIwZTNjYWE0ODEgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29u
L2NwdS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCkBAIC04NzQsNiArODc0LDkgQEAgc3Rh
dGljIGNvbnN0IFR5cGVJbmZvIGhleGFnb25fY3B1X3R5cGVfaW5mb3NbXSA9IHsKICAgICBERUZJ
TkVfQ1BVKFRZUEVfSEVYQUdPTl9DUFVfVjY5LCAgICAgICAgICAgICAgSEVYX1ZFUl9WNjkpLAog
ICAgIERFRklORV9DUFUoVFlQRV9IRVhBR09OX0NQVV9WNzEsICAgICAgICAgICAgICBIRVhfVkVS
X1Y3MSksCiAgICAgREVGSU5FX0NQVShUWVBFX0hFWEFHT05fQ1BVX1Y3MywgICAgICAgICAgICAg
IEhFWF9WRVJfVjczKSwKKyAgICBERUZJTkVfQ1BVKFRZUEVfSEVYQUdPTl9DUFVfVjc1LCAgICAg
ICAgICAgICAgSEVYX1ZFUl9WNzUpLAorICAgIERFRklORV9DUFUoVFlQRV9IRVhBR09OX0NQVV9W
NzksICAgICAgICAgICAgICBIRVhfVkVSX1Y3OSksCisgICAgREVGSU5FX0NQVShUWVBFX0hFWEFH
T05fQ1BVX1Y4MSwgICAgICAgICAgICAgIEhFWF9WRVJfVjgxKSwKIH07CiAKIERFRklORV9UWVBF
UyhoZXhhZ29uX2NwdV90eXBlX2luZm9zKQotLSAKMi4zNC4xCgo=

