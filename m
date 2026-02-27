Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C61D71039895
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 20:39:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw4Zw-0006pJ-Jn; Fri, 27 Feb 2026 15:36:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vw4Zv-0006om-KB
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:36:51 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vw4Zu-0006pM-3D
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:36:51 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61RH0JK5131873
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 20:36:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5YH3xpSNAAZZ79w0uJkjUF2He2ZiaPFZXERY1SdonwA=; b=UMWuYVL6MANKo+u3
 532yFQTqSx8/5RPi/elKQSGF+64//DLHxF/FcLnti7MYy5lXZtTKK4vpFUc9Ylcf
 euFmaqXeC7SCoPho6N/zDmai/eKciNweW+8+YIsLO+RNqBjz+hMb1pKPpIFv2/JS
 ZmjJyOkN3Ckvzv2/7CnrN4Om174y3mHdtWIYRTky1opi3HYMJ/dU6o4E7jZ9KScA
 Uz2oFG2emzavxMF8j6bW6lkUw6uRmSpo/656YsnGKGIKqykhIbq0VDiMCCYToqzq
 mMWZoGzPAadUqG7i/PaBzyb2uCgsJJqRWaD1UTz7mUs4nrv7dW4D5xadTiAeTtuH
 g0BdLA==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ck43rb2nu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 20:36:48 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-45f07dad7a8so11333356b6e.0
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 12:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1772224608; x=1772829408; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5YH3xpSNAAZZ79w0uJkjUF2He2ZiaPFZXERY1SdonwA=;
 b=ASd0MwbqXALzDhv43/85+X2TXDTzpKm9XGsNDJ7UHLB3ERw/Lap3MVqebOXjX5uTjG
 1GXn452oD8u+4gRL+6haXPHufnvyR532HoOHUlL5hy/05X47nl/rTYcVb6gYhdOkzISm
 MM28AobbbGiihBR3TSBrTvRfcVvdQFAOjMT13ujTmIR8wd501fgUWz1IAYl38kqPZBeE
 2vAcH7SALCw/50CMZXv7Bf7sDlldfzDMexPCM4YrrZninglns0HjPhuG3IlFBpYaEA2U
 1758SXYakQy/U6bUFCNxTbtwsr2sopLZKD3IDE2Tpkn9+9AQD4qbS4Yw2xofmbJguTIB
 pb3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772224608; x=1772829408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5YH3xpSNAAZZ79w0uJkjUF2He2ZiaPFZXERY1SdonwA=;
 b=cZE/rKYSkGBqeSMFO/8USUM9UEI2q0dPSePyYZUrJNafCMGJg7SC7lh53nQAXyRxJg
 0183EQwXwpa+g0NyTq4zd+2YX1Bm1VC9xJjxGNkxgKxdB6djei+nYisnFv4c0gTmCYWn
 DlDgsVfvkjVdovlXYHntmSRmxk3a61zhm7lM/fBJoU5nziTXgsYrFZCAJCkGeCjiq/k/
 ptFygy3fAze/jgPIm7qjxubHU1/WjoDyyXc//Pvv2WMfYnfeLUIdtlHVEZSce0svg74V
 OhIw17f3DcJCcVAQ1JPMBClfqBBFhKHDLCxnECZbTHoKm5QI35UhcQenAIYirhlbQHJr
 AeEg==
X-Gm-Message-State: AOJu0Yxc09DbPD8Z48bYf/BWMszzs+gPRax5uz+Jcm7ImBR3jCFugkM+
 GB9lXiCeEPhKE3dpvHw7K7RLWrXAgHFqJgVLuLCpN+5I5nGqSEtTk4OGAolGtXPMgg3bh8YYYhD
 VsTOF9qvzLUqFC0F8bsMEmc3Y0bKfjGxHSqdTnwuFxTvQ4i9L7JC78CGDPVn/n0PmvA==
X-Gm-Gg: ATEYQzzaF7vSFTt+WvdfON2t1X/US4pNl3geaSEja9TC99ot/TPb2dFR+7S7QtiJW5i
 thWTUfyYPakYLUZCEb0kAnGImnc3UQ0RO0z05+IVQYcc/4oJTrQVNH00hrD8iIzwJbz+DdCxFmX
 hhsLTB8FoEnc4HVVL6IW8VGwALIvNFZ5//rKv895WJSjVWKIHKoDI8lb5PkSo68XQXdwUH/dCJ9
 LwPcQyOiC/qzo4kUstJfJiV4uIif4qCg6oMwZ/2h72m1oY/nzqvPwI3SmjSPwMHshcq9VWv3vsY
 d/A2H86TE49rAdTVTElzGyedWItFK8KO2ONijEQ7V48ShYCj2PHO1aLouG7wp6PdSmR1+zSaeP8
 Zam9/yLWc7PcbsELLUUW4oZrnluuU7K7QOhFT19FYrzZ7UOGjpfCzXidYuyikqk7mV4+JDg==
X-Received: by 2002:a05:6808:4f53:b0:450:b8da:b800 with SMTP id
 5614622812f47-464bef4dc12mr2526998b6e.47.1772224607947; 
 Fri, 27 Feb 2026 12:36:47 -0800 (PST)
X-Received: by 2002:a05:6808:4f53:b0:450:b8da:b800 with SMTP id
 5614622812f47-464bef4dc12mr2526988b6e.47.1772224607593; 
 Fri, 27 Feb 2026 12:36:47 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4160cbd405fsm5762935fac.0.2026.02.27.12.36.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 12:36:47 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v3 10/37] target/hexagon: Add memory order definition
Date: Fri, 27 Feb 2026 12:36:00 -0800
Message-Id: <20260227203627.932864-11-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
References: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: JT1592ZHN9c6GY68_FbiMvAwGMhnwPrh
X-Proofpoint-GUID: JT1592ZHN9c6GY68_FbiMvAwGMhnwPrh
X-Authority-Analysis: v=2.4 cv=DOqCIiNb c=1 sm=1 tr=0 ts=69a20060 cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=SgXgUqScEDldHOCFpxoA:9 a=QEXdDO2ut3YA:10
 a=_Y9Zt4tPzoBS9L09Snn2:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE4MSBTYWx0ZWRfX2TWHfUtrX83R
 IPjGQ9aLy5pyaEnTXL4ytB//SyYnEMx5N6ti99ZvR/FpNgAGADCxYF7riC8w4YX3tW6432BcCgR
 9AyePh/Qji95bPFFc3xIq1fckx6uBbPkG/j6441Exi1ahCc1rRvK/kINtKU9prUt4BUJH8vCF3G
 Kau+lqCnhXptiIKYPG4Tm3CwjSN69ElySRHA4fpjTp6k6FfsvI7aZPgyTFJcDszOyqMhQ1q24Fv
 np9Q9aGpxoRxPW7k+DAxXNz8t8WkunjbH6AePqchD6wBWAxwSIJ+jyWPA4MFT7PWboLPKo3zkbm
 Kkrg6SAkJrb+xG/osZ361UDNCqzYIg+QRBlvgudi7zj1waxT3PoJQuw9uWDl8hd61/jqIEEGIVQ
 Z2W5UmW2baziRLllRVDYqMmu+Dfe6Q1lfptokraEQE5UFwGyXY/5Oy2gW00pOoU2DFSCHd3/4l/
 1Dd1a7JV4IfSkbnDc7g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_04,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270181
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24v
Y3B1LXBhcmFtLmggfCA1ICsrKysrCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspCgpk
aWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LXBhcmFtLmggYi90YXJnZXQvaGV4YWdvbi9j
cHUtcGFyYW0uaAppbmRleCA0NWVlN2I0NjQwOS4uY2NhZjZhOWQyOGQgMTAwNjQ0Ci0tLSBhL3Rh
cmdldC9oZXhhZ29uL2NwdS1wYXJhbS5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS1wYXJhbS5o
CkBAIC0yMyw0ICsyMyw5IEBACiAjZGVmaW5lIFRBUkdFVF9QSFlTX0FERFJfU1BBQ0VfQklUUyAz
NgogI2RlZmluZSBUQVJHRVRfVklSVF9BRERSX1NQQUNFX0JJVFMgMzIKIAorLyoKKyAqIEhleGFn
b24gcHJvY2Vzc29ycyBoYXZlIGEgc3Ryb25nIG1lbW9yeSBtb2RlbC4KKyAqLworI2RlZmluZSBU
Q0dfR1VFU1RfREVGQVVMVF9NTyAgICAgIChUQ0dfTU9fQUxMKQorCiAjZW5kaWYKLS0gCjIuMzQu
MQoK

