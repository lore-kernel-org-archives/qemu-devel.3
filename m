Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42FBACA9ED9
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:20:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xG7Ug-0002KD-6j; Mon, 12 Oct 2026 00:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xG7U6-0001wD-E9
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 00:17:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xG7U3-00019F-H6
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 00:17:57 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C1lHw9328248
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 04:17:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Mx/s3RlzAz7+uVrqyVMPIAXgyVHf9NRvKzpley8JlZk=; b=LwoqD5AgBCniEh5p
 2qpG8wVhOMQ7Qd9mA9bg/X6cwqVq2a0nOwbNoB8cYULxG468f/We2wNSouY7Poj4
 fSw0/0EUFGekgQvtSnHHt0yP4LeoSNmz9nhCsiVtcpxq6SOT2cS5iDscSBnXvlCv
 Gg8S/wRT9hH/orKqOea09TeJVHplOSKJnyMEadQGEDEc7G8sAniRHAC5xQqESEKS
 R7qzBu0MNPhBLysbMRaEJbynKyjvFl8kaeDQEo6/AaYkh348J0vX5AF36KFOMSRZ
 LB0TKDDzh6Wbl4GZDJn27hBpb9hK4lCRVpmOr53dyEXbXjc2DVBG0b3Jk1sZcJac
 jCU9Bg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7e4ech9s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 04:17:44 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-35ac5255f1dso1664755eec.0
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2026 21:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791778664; x=1792383464; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Mx/s3RlzAz7+uVrqyVMPIAXgyVHf9NRvKzpley8JlZk=;
 b=hM4IO+XbEFxumesSZU41K7et9sBLcKqifda8IcqsdGwUF7ymDfN3gr1Kdc+9ogFOLS
 R5oRt+UgFk+8pz/oW+mcgIrOE4OTUqWAnSTtB3Cncwk/q0bA95RV9ZmejaGI5GaUyr35
 vE9UU7SnE2ZCo2nSy++g+y6gIGx0zXsqnUUqfio8DS4B7yi0iv/wXtZ+s51cJVsFceSJ
 bCtRihxQCY3OT7Pp8xqSrf7KsU+Pq11BX+OtKPmcYqpuniAYFMbf2S7VBVzque25F7fm
 fMfAKMvTdR1njn8pg9N3hvzSXY114dhCyzu4LQs+uVUf8BYmErWgJz5tgYfpw824Bkab
 UMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791778664; x=1792383464;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Mx/s3RlzAz7+uVrqyVMPIAXgyVHf9NRvKzpley8JlZk=;
 b=Y9erLpRjL14yj0ayy26XwlqmSldd42z9U4kVtI4U0Fdtvm8ufzwGD+DaeRdDD2PU/+
 91x5I9plqCciZ8jpKebv1jPMKIYF2HKWfdPs+25kZCpop8uXJ/gjqj0PcXb8pXD83pAr
 +Dx2zp13OmlzbxrXBWbtSHe2ljF2by1A+/KJfBfH9Nvs76etdrvF/Te+v9OUGCR05Szh
 8Mm4P0Q+VRA/73FOuC+XQXc//Yd7W3i/AprRdpW8QtDvo+Yktxe8Adfo7hbh1QYP9Wb4
 e9fWSmwfwj+Gwq7Aw8OQIrcaNuZKAajC1FKGhJ6X7euEvjw4ECcfdUghl7K5PAySeBfH
 M4rQ==
X-Gm-Message-State: AFq9FYIwpHqR5qIK4dWzA5V6P/Kn3kZqGEq3gxdZ4CqdvDTfyiaEmXFo
 uBWxL/TSjmj6ZZfQteo/XVRVMpYJbRapUSz8znUydyyPA/6dpPowfgRVirOR63Az17yowKlzIOT
 uwE18aY8Cm4J1UhfkS/RDcHxuFviU1lmg8tVD8IpEjpPFqO4xcPaeejWNC66SjXzeEw==
X-Gm-Gg: AYBFou2ztTrGLAhviFhPJBQ8gya5SPzSPtcPFgPMA8pZwPO7xcG7x4SAXHYGYpc5+Ye
 7mHp9ZIQ5feUBS0d727LHXSEW1Mb0nL7LbyEGGPGThGZqyiBDpskFl07ifT8qyD3NGiK4wK8WZq
 dkFDOsTKkSfA+M3ZUrbLkQpadN+87wD9neeHEKbgTtEvmWmqTCtpkOap7VNZdVNyPxLjvpZ6ldx
 yGu43NACNYrFUY8x7VNgKaG4dLHAnk3zodlGBpmUB+vbsdF2qyogS+sAqys2yEclldWYI7SkHyn
 NehZNMxJaDvKV7tbbbQ8NSK6o4gDHipulhYmoEN5m0YmsstHhHVi6awN63Ff7opcx+1IJcmCYGs
 fim+npsbnAzQIT+GoB/AKTvjCCCvyb+pdB4CmvO5x9zf9QpM=
X-Received: by 2002:a05:693c:42c9:b0:359:9e84:dc99 with SMTP id
 5a478bee46e88-3599e84ea9bmr4114267eec.0.1791778663505; 
 Sun, 11 Oct 2026 21:17:43 -0700 (PDT)
X-Received: by 2002:a05:693c:42c9:b0:359:9e84:dc99 with SMTP id
 5a478bee46e88-3599e84ea9bmr4114247eec.0.1791778662898; 
 Sun, 11 Oct 2026 21:17:42 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537c841648sm32369096eec.3.2026.10.11.21.17.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 21:17:41 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Marco Liebel <marco.liebel@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 11/25] target/hexagon: fix V6_vcmov reserved-bit encoding
Date: Sun, 11 Oct 2026 21:17:08 -0700
Message-Id: <20261012041722.1159355-12-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261012041722.1159355-1-brian.cain@oss.qualcomm.com>
References: <20261012041722.1159355-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAxNiBTYWx0ZWRfX+bQYpro1c+ln
 /nBXgdHVi/Jg/oUfjeUD40StyqEsgSTm5CfZRInjqZtI+EhcmsTUwlzTjtJdtLuXh4fLi5OANVn
 fqQ3XcCYxSanDvh6dJQFc2LY+Sy4VpgsHIlKA1F47UBnB4ySqj6J9Sc7fmos8gsaRuPSXpYVd1s
 JEweIO7YkbWDMxddvu+khckw6BFikVP5dcfXVy+wDvW4V5awnmuXAC9OcX20x1QAKGUd8dR0jm/
 Dmj8EMQzlImBF3iEVoJfVlMy49UC/egHJiXdymBsJ1eR2s2CIwIsw0zaCuAxWYeYQ077vl4sZpJ
 mrEJ3LP6DJcmwyi1/neGVxSiGjp3o/cGHzCt7lao6Uj7kKt6+Ewzah2g7SmgbtfbWj23ULtONlf
 XkFZV/bijP4oVDSBl23/CJiZ/KEhmkEzwl+p3GLYEfogK+919MzCFqXdIzacg4VgBONEPzxor2n
 X7LT7nAMtDI+a+tx5TQ==
X-Proofpoint-ORIG-GUID: 0cjCHPs9_dtcg3qaut1mh6jfO3HMKfEm
X-Proofpoint-GUID: 0cjCHPs9_dtcg3qaut1mh6jfO3HMKfEm
X-Authority-Analysis: v=2.4 cv=W5utxhWk c=1 sm=1 tr=0 ts=6acc5f68 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=ptefoZwEObSeWYFtGJoA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAxNiBTYWx0ZWRfX/22fDQQu4bW/
 YCGvIL78Ep2YEPs9mKjhwNPSJHsYUKfvpffblol+NLaRIbSyKi4gjWg5XX0ea1xC/0DLdzRd4Ls
 Tgd7omdp2zer6eTR8b1GfSrLhEJjP2Y=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120016
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

VGhlIGFyY2hpdGVjdHVyZSBkZWZpbmVzIHRoaXMgZW5jb2RpbmcgYml0IGFzIHplcm8uICBMZWF2
aW5nIGl0CnVuY29uc3RyYWluZWQgYWNjZXB0cyByZXNlcnZlZCBlbmNvZGluZ3MgYXMgVjZfdmNt
b3YuCgpSZXZpZXdlZC1ieTogTWFyY28gTGllYmVsIDxtYXJjby5saWViZWxAb3NzLnF1YWxjb21t
LmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0u
Y29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2ltcG9ydGVkL21tdmVjL2VuY29kZV9leHQuZGVmIHwg
MiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZm
IC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQvbW12ZWMvZW5jb2RlX2V4dC5kZWYgYi90
YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9tbXZlYy9lbmNvZGVfZXh0LmRlZgppbmRleCAwODRhZTNk
ODU0Mi4uYjQ2ZjUxNDkyZDkgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2ltcG9ydGVkL21t
dmVjL2VuY29kZV9leHQuZGVmCisrKyBiL3RhcmdldC9oZXhhZ29uL2ltcG9ydGVkL21tdmVjL2Vu
Y29kZV9leHQuZGVmCkBAIC0zOTQsNyArMzk0LDcgQEAgREVGX0VOQyhWNl92c2h1ZmYsICAgICAg
ICAgICAgIElDTEFTU19DSiIgMSAwMDEgMTExIHR0dHR0IFBQIDEgeXl5eXkgMDAxIHh4eHh4IikK
IERFRl9FTkMoVjZfdmRlYWwsICAgICAgICAgICAgIElDTEFTU19DSiIgMSAwMDEgMTExIHR0dHR0
IFBQIDEgeXl5eXkgMDEwIHh4eHh4IikgLy8KIAogREVGX0ZJRUxEUk9XX0RFU0MzMiggICAgSUNM
QVNTX0NKIiAxIDAxMCAtLS0gLS0tLS0gUFAgLSAtLS0tLSAtLS0tLSAtLS0iLCJbIzJdIGlmIChQ
cykgVmQ9VnUiKQotREVGX0VOQyhWNl92Y21vdiwgICAgICAgICBJQ0xBU1NfQ0oiIDEgMDEwIDAw
MCAtLS0tLSBQUCAtIHV1dXV1IC1zcyBkZGRkZCIpCitERUZfRU5DKFY2X3ZjbW92LCAgICAgICAg
IElDTEFTU19DSiIgMSAwMTAgMDAwIC0tLS0tIFBQIDAgdXV1dXUgLXNzIGRkZGRkIikKIERFRl9F
TkMoVjZfdm5jbW92LCAgICAgICAgIElDTEFTU19DSiIgMSAwMTAgMDAxIC0tLS0tIFBQIC0gdXV1
dXUgLXNzIGRkZGRkIikKIERFRl9FTkMoVjZfdm5jY29tYmluZSwgICAgIElDTEFTU19DSiIgMSAw
MTAgMDEwIHZ2dnZ2IFBQIC0gdXV1dXUgLXNzIGRkZGRkIikKIERFRl9FTkMoVjZfdmNjb21iaW5l
LCAgICAgSUNMQVNTX0NKIiAxIDAxMCAwMTEgdnZ2dnYgUFAgLSB1dXV1dSAtc3MgZGRkZGQiKQot
LSAKMi4zNC4xCgo=

