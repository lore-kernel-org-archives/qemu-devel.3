Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2BADC4451B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 19:16:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wko2c-0006qU-HE; Fri, 17 Jul 2026 15:16:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wko2b-0006pv-3P
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 15:16:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wko2Z-00085r-CU
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 15:16:08 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HGoNY02372999
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 19:16:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zqu/caR8qUOFriN6mz6fEU2gUD5dQmgerya3OVTiR0g=; b=L+KGkRf6p+oKOC5x
 LNz7cjCiLwJKo4EXDipOQLx1Hh8GNgn2v/l+aK76PjKZ0qP2w5Hb0rE7fcR752Av
 YR4cOH3FGKD9bS01+HmbpjhIViwOHlJcHfuGpQ/wc4/uIsKJ8WFgTtoS3/bh7uim
 3+diHeZ6yA0qM6OMwD50abU8xfX18+lUQDwcTE0kdtofnLtNjNH65zC76CCFXzD2
 4evuyp6ap8wK0rlyMWrYHist3va/Fhi48gVbAX8U5k+H0LDuP8iKxamxNVMKYTbN
 s4HQiN+aVUOsrj/PfwAM0nyTPhlrChKyx0fUmB4mACDayW4GdhfTCZxmiwyywg/Z
 hppLoA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fff9gu01x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 19:16:06 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38dde0df80bso10407106a91.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 12:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784315765; x=1784920565; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zqu/caR8qUOFriN6mz6fEU2gUD5dQmgerya3OVTiR0g=;
 b=dxPe7NsKQnet3akJtx4U385BWxmsPPaNMR+BblwbJYt99Gn3gvKuNFRWQC9yjJKzfA
 IJLSvisgJ1YUdiBvjaitl8cQ+oJp2n3Si/J/U+RLtFD4DMAkMyOwZfYsiPqDZtwBKzjW
 /dR4hzgGWzTo6eaPLMT2z/54Me8Qr9UOS/8thLb2LW/rsTe2/Aj5FxhAaM8d8TSN7rkC
 YrP0as5jwiCc3tfj3ssU1IdqMDHld9UKr+4R96xp8XsGUK4nsHWluM4lTCfJUVmZFDaC
 OoDK8zoSwpq/vKbDlSsz3wIlsZaZ7nMdsNKY+uvC2oHF1XGuo/qc9OjfX/IrriIsN2f8
 gd1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784315765; x=1784920565;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zqu/caR8qUOFriN6mz6fEU2gUD5dQmgerya3OVTiR0g=;
 b=avaVGs3TgyB3FyRN0X36p3ntY3WFH7BsHhxq21lAXI8i9iC54FToKy/a4vgOoWDA8E
 BDF+iqzOLTlhc3twLKAcmYbWYSp/8lGK5ME6pu81dkQ05SVSNasl+FQSlviHYJyJDqA1
 5uK1sE8tDYVMR6sw7hiE3Zsslk9ZlfhENH7wFrzm34GbJsVRPjheapKJ1Pi4X3qlfbtX
 rAQZSPVwrzk74Sn45FU7C/kbW5F9TrIDvb+R98f+qx0PsTyyd04b14WLYEqtk91qijzJ
 AEwZjO23HSA34dI0X0yZHgJCsFyx33WMumbn776qv8AnNqp3XVu6kzNquj0aqOWAK+FX
 W01g==
X-Gm-Message-State: AOJu0Yx5vNWz9dQp9esu0YA3A0pmzG6Wl/BfCV3ZWRq/s+Wzk5WpEwo2
 IgeeumFWwuTziKcN3wHiu+mE1ea79GZLmGwAazt2puFD0lp/l2T4AmROm872HzdUFeHe4R9Hy6w
 6vBuqESLXCvxQCvtJVmMEPVZ8WOB2d2PwwM0ZcUtXk+snev74RyJxK70J5jnFT37MtQ==
X-Gm-Gg: AfdE7cnOFKU3QdJmT3KyqNTfaes7dxbdhUgR+AfXZrzhwqBYd8m4y/SRhkuU18AVONB
 SWU8IdNykDTkSoasb2MOM/NNP7/F7MNZBlH0To3vqdoNW0aWqSRmyFipy9r9OCCmSCkQu7WlQhT
 p7FXAiqSxSmSGolNpP6/Q8U+6/5ABhNCt4SjFhCfODdWq2bkEnc0ul+k4Zw2ns1es6DU9IOsBUq
 X8pkRMeaMnhUZPGGdMcDCxOXX9M3f6+ENKCwLSFjYbOB6mAlZRFqm3bqPyoH81Ye0BfjKkbeaoc
 H9dH6dvPbyP29TChLwGh9SW2D7/tszFIsX5cDKbRPLQDf1Hk9DPbypIbD4KyeXzMRkz8L2Gzzas
 OJG2/uo6d6HxmnO5QbxDUKW2bkPTvO2iRIhAtMjyfFf25iVm2
X-Received: by 2002:a17:90b:58ee:b0:387:e0cb:7f3 with SMTP id
 98e67ed59e1d1-38e4b58a223mr3574619a91.39.1784315764934; 
 Fri, 17 Jul 2026 12:16:04 -0700 (PDT)
X-Received: by 2002:a17:90b:58ee:b0:387:e0cb:7f3 with SMTP id
 98e67ed59e1d1-38e4b58a223mr3574580a91.39.1784315764346; 
 Fri, 17 Jul 2026 12:16:04 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31429f9d444sm11602463eec.6.2026.07.17.12.16.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 12:16:03 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, stefanha@redhat.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 08/12] tests/tcg/hexagon: add unaligned scalar test
Date: Fri, 17 Jul 2026 12:15:43 -0700
Message-Id: <20260717191547.920048-9-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260717191547.920048-1-brian.cain@oss.qualcomm.com>
References: <20260717191547.920048-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE5NyBTYWx0ZWRfXweRiHIGii0Xt
 kffyDD39kvkOI+7kvUldw8ZSMrKlehPNItu8FbPG4m1jtdVUXUexa5eIWfQDSpMCAA6UcDBHH50
 dg3FNT/8wfqbYqW2Hck3i1QdrpdyvFc=
X-Proofpoint-ORIG-GUID: OMmqL4F5y0shn1eYAv4qX1rsSXcjyDfN
X-Proofpoint-GUID: OMmqL4F5y0shn1eYAv4qX1rsSXcjyDfN
X-Authority-Analysis: v=2.4 cv=TaumcxQh c=1 sm=1 tr=0 ts=6a5a7f76 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=JA4W_Hs6HDHytmC4mdIA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE5NyBTYWx0ZWRfXyQ4odsj1NHm+
 ds/IkmNn6/2utKSt45iRM8IrA4PokODqr4oanNhMG9IXYNeG4t9Lguo9KTHOtaMvn6QYOWXohyP
 6kXAJZ2ggQm5LuTP+byK9qH9AGaaOZI41TiwyRyPveS45B4EkvXPgmC4DwsXwtbM6Z/q4Hgt1FU
 cj2pCxIuyVoTDRecjn6ZdU7nKkQBMsJBFbjaxnc3U6BAwEe1obHbE4Daa9HQHxSjHnxgjolV1Nk
 dERcqowP6dDH1eO3eaWKBeHJwfbUfmW8yepOlCMNbLbN1KrUQo6Wy8D8+Q8U1grdd5GI/kqWOrY
 aG6L7QDagHXgH25cLp1ueVIECzUReQN1sHAe+vlqIUO/j3vJAqatdq1M6EPat2XsYM0Xo0Rzgtu
 HEloyO8S+WYIiNlUpBjGcxzfcPtVfP9yfJjcT/GQVFr8u+IYB3X8c/zCICsurYyFtd6JaZqixgy
 SvtrnuyNJDSAxQimxbw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_05,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 adultscore=0 phishscore=0
 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170197
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

QWRkIHVuYWxpZ25lZF9kYXRhLmMgdG8gZXhlcmNpc2UgdW5hbGlnbmVkIG1lbWgvbWVtdy9tZW1k
IGFjY2Vzc2VzIGFuZAp2ZXJpZnkgU0lHQlVTIGlzIHJhaXNlZCBhbmQgY2F1Z2h0LgoKUmV2aWV3
ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxjb21tLmNv
bT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29t
PgotLS0KIHRlc3RzL3RjZy9oZXhhZ29uL3VuYWxpZ25lZF9kYXRhLmMgfCAxMTggKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysKIHRlc3RzL3RjZy9oZXhhZ29uL01ha2VmaWxlLnRhcmdldCAg
fCAgIDIgKwogMiBmaWxlcyBjaGFuZ2VkLCAxMjAgaW5zZXJ0aW9ucygrKQogY3JlYXRlIG1vZGUg
MTAwNjQ0IHRlc3RzL3RjZy9oZXhhZ29uL3VuYWxpZ25lZF9kYXRhLmMKCmRpZmYgLS1naXQgYS90
ZXN0cy90Y2cvaGV4YWdvbi91bmFsaWduZWRfZGF0YS5jIGIvdGVzdHMvdGNnL2hleGFnb24vdW5h
bGlnbmVkX2RhdGEuYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMC4uZTAz
NzVmYWFmYmUKLS0tIC9kZXYvbnVsbAorKysgYi90ZXN0cy90Y2cvaGV4YWdvbi91bmFsaWduZWRf
ZGF0YS5jCkBAIC0wLDAgKzEsMTE4IEBACisvKgorICogQ29weXJpZ2h0IChjKSBRdWFsY29tbSBU
ZWNobm9sb2dpZXMsIEluYy4gYW5kL29yIGl0cyBzdWJzaWRpYXJpZXMuCisgKiBTUERYLUxpY2Vu
c2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcgorICovCisKKy8qCisgKiBUZXN0IHRoYXQg
dW5hbGlnbmVkIHNjYWxhciBsb2FkcyByYWlzZSBTSUdCVVMuCisgKi8KKworI2luY2x1ZGUgPHN0
ZGxpYi5oPgorI2luY2x1ZGUgPHN0ZGlvLmg+CisjaW5jbHVkZSA8c3RkaW50Lmg+CisjaW5jbHVk
ZSA8c3RkYm9vbC5oPgorI2luY2x1ZGUgPHNldGptcC5oPgorI2luY2x1ZGUgPHNpZ25hbC5oPgor
CitpbnQgZXJyOworCisjaW5jbHVkZSAiaGV4X3Rlc3QuaCIKKworc3RhdGljIGJvb2wgc2lnYnVz
X2NhdWdodDsKK3N0YXRpYyBzaWdqbXBfYnVmIGptcF9lbnY7CitzdGF0aWMgdWludDY0X3QgYnVm
WzJdID0geyAwLCAwIH07CisKK3N0YXRpYyB2b2lkIHNpZ2J1c19oYW5kbGVyKGludCBzaWcsIHNp
Z2luZm9fdCAqaW5mbywgdm9pZCAqcHVjKQoreworICAgIGNoZWNrMzIoc2lnLCBTSUdCVVMpOwor
ICAgIHNpZ2J1c19jYXVnaHQgPSB0cnVlOworICAgIHNpZ2xvbmdqbXAoam1wX2VudiwgMSk7Cit9
CisKK3N0YXRpYyB2b2lkIHRlc3RfdW5hbGlnbmVkX2xvYWQoaW50IHNpemUsIGludCBvZmZzZXQp
Cit7CisgICAgY2hhciAqcCA9IChjaGFyICopYnVmICsgb2Zmc2V0OworICAgIHVpbnQzMl90IGR1
bW15MzI7CisgICAgdWludDY0X3QgZHVtbXk2NDsKKworICAgIHNpZ2J1c19jYXVnaHQgPSBmYWxz
ZTsKKyAgICBpZiAoc2lnc2V0am1wKGptcF9lbnYsIDEpID09IDApIHsKKyAgICAgICAgc3dpdGNo
IChzaXplKSB7CisgICAgICAgIGNhc2UgMjoKKyAgICAgICAgICAgIGFzbSB2b2xhdGlsZSgiJVtk
c3RdID0gbWVtaCglW3NyY10pXG5cdCIKKyAgICAgICAgICAgICAgICAgICAgICAgICAgOiBbZHN0
XSAiPXIiKGR1bW15MzIpIDogW3NyY10gInIiKHApIDogIm1lbW9yeSIpOworICAgICAgICAgICAg
YnJlYWs7CisgICAgICAgIGNhc2UgNDoKKyAgICAgICAgICAgIGFzbSB2b2xhdGlsZSgiJVtkc3Rd
ID0gbWVtdyglW3NyY10pXG5cdCIKKyAgICAgICAgICAgICAgICAgICAgICAgICAgOiBbZHN0XSAi
PXIiKGR1bW15MzIpIDogW3NyY10gInIiKHApIDogIm1lbW9yeSIpOworICAgICAgICAgICAgYnJl
YWs7CisgICAgICAgIGNhc2UgODoKKyAgICAgICAgICAgIGFzbSB2b2xhdGlsZSgiJVtkc3RdID0g
bWVtZCglW3NyY10pXG5cdCIKKyAgICAgICAgICAgICAgICAgICAgICAgICAgOiBbZHN0XSAiPXIi
KGR1bW15NjQpIDogW3NyY10gInIiKHApIDogIm1lbW9yeSIpOworICAgICAgICAgICAgYnJlYWs7
CisgICAgICAgIGRlZmF1bHQ6CisgICAgICAgICAgICBhYm9ydCgpOworICAgICAgICB9CisgICAg
fQorICAgIGNoZWNrMzIoc2lnYnVzX2NhdWdodCwgdHJ1ZSk7Cit9CisKK3N0YXRpYyB2b2lkIHRl
c3RfdW5hbGlnbmVkX3N0b3JlKGludCBzaXplLCBpbnQgb2Zmc2V0KQoreworICAgIGNoYXIgKnAg
PSAoY2hhciAqKWJ1ZiArIG9mZnNldDsKKyAgICB1aW50MzJfdCB2YWwzMiA9IDB4MTEyMjMzNDQ7
CisgICAgdWludDY0X3QgdmFsNjQgPSAweDExMjIzMzQ0NTU2Njc3ODhVTEw7CisKKyAgICBzaWdi
dXNfY2F1Z2h0ID0gZmFsc2U7CisgICAgaWYgKHNpZ3NldGptcChqbXBfZW52LCAxKSA9PSAwKSB7
CisgICAgICAgIHN3aXRjaCAoc2l6ZSkgeworICAgICAgICBjYXNlIDI6CisgICAgICAgICAgICBh
c20gdm9sYXRpbGUoIm1lbWgoJVthZGRyXSkgPSAlW3ZhbF1cblx0IgorICAgICAgICAgICAgICAg
ICAgICAgICAgICA6IDogW2FkZHJdICJyIihwKSwgW3ZhbF0gInIiKHZhbDMyKSA6ICJtZW1vcnki
KTsKKyAgICAgICAgICAgIGJyZWFrOworICAgICAgICBjYXNlIDQ6CisgICAgICAgICAgICBhc20g
dm9sYXRpbGUoIm1lbXcoJVthZGRyXSkgPSAlW3ZhbF1cblx0IgorICAgICAgICAgICAgICAgICAg
ICAgICAgICA6IDogW2FkZHJdICJyIihwKSwgW3ZhbF0gInIiKHZhbDMyKSA6ICJtZW1vcnkiKTsK
KyAgICAgICAgICAgIGJyZWFrOworICAgICAgICBjYXNlIDg6CisgICAgICAgICAgICBhc20gdm9s
YXRpbGUoIm1lbWQoJVthZGRyXSkgPSAlW3ZhbF1cblx0IgorICAgICAgICAgICAgICAgICAgICAg
ICAgICA6IDogW2FkZHJdICJyIihwKSwgW3ZhbF0gInIiKHZhbDY0KSA6ICJtZW1vcnkiKTsKKyAg
ICAgICAgICAgIGJyZWFrOworICAgICAgICBkZWZhdWx0OgorICAgICAgICAgICAgYWJvcnQoKTsK
KyAgICAgICAgfQorICAgIH0KKyAgICBjaGVjazMyKHNpZ2J1c19jYXVnaHQsIHRydWUpOworfQor
CitpbnQgbWFpbigpCit7CisgICAgc3RydWN0IHNpZ2FjdGlvbiBhY3Q7CisKKyAgICBhY3Quc2Ff
c2lnYWN0aW9uID0gc2lnYnVzX2hhbmRsZXI7CisgICAgc2lnZW1wdHlzZXQoJmFjdC5zYV9tYXNr
KTsKKyAgICBhY3Quc2FfZmxhZ3MgPSBTQV9TSUdJTkZPOworICAgIGNoa19lcnJvcihzaWdhY3Rp
b24oU0lHQlVTLCAmYWN0LCBOVUxMKSk7CisKKyAgICB0ZXN0X3VuYWxpZ25lZF9sb2FkKDIsIDEp
OworICAgIHRlc3RfdW5hbGlnbmVkX2xvYWQoNCwgMSk7CisgICAgdGVzdF91bmFsaWduZWRfbG9h
ZCg0LCAyKTsKKyAgICB0ZXN0X3VuYWxpZ25lZF9sb2FkKDQsIDMpOworICAgIHRlc3RfdW5hbGln
bmVkX2xvYWQoOCwgMSk7CisgICAgdGVzdF91bmFsaWduZWRfbG9hZCg4LCA0KTsKKworICAgIHRl
c3RfdW5hbGlnbmVkX3N0b3JlKDIsIDEpOworICAgIHRlc3RfdW5hbGlnbmVkX3N0b3JlKDQsIDEp
OworICAgIHRlc3RfdW5hbGlnbmVkX3N0b3JlKDQsIDIpOworICAgIHRlc3RfdW5hbGlnbmVkX3N0
b3JlKDQsIDMpOworICAgIHRlc3RfdW5hbGlnbmVkX3N0b3JlKDgsIDEpOworICAgIHRlc3RfdW5h
bGlnbmVkX3N0b3JlKDgsIDQpOworCisgICAgYWN0LnNhX2hhbmRsZXIgPSBTSUdfREZMOworICAg
IHNpZ2VtcHR5c2V0KCZhY3Quc2FfbWFzayk7CisgICAgYWN0LnNhX2ZsYWdzID0gMDsKKyAgICBj
aGtfZXJyb3Ioc2lnYWN0aW9uKFNJR0JVUywgJmFjdCwgTlVMTCkpOworCisgICAgcHV0cyhlcnIg
PyAiRkFJTCIgOiAiUEFTUyIpOworICAgIHJldHVybiBlcnIgPyBFWElUX0ZBSUxVUkUgOiBFWElU
X1NVQ0NFU1M7Cit9CmRpZmYgLS1naXQgYS90ZXN0cy90Y2cvaGV4YWdvbi9NYWtlZmlsZS50YXJn
ZXQgYi90ZXN0cy90Y2cvaGV4YWdvbi9NYWtlZmlsZS50YXJnZXQKaW5kZXggNzBhOGVjMmU3ZmIu
LmEyYTBmZmM2OWIyIDEwMDY0NAotLS0gYS90ZXN0cy90Y2cvaGV4YWdvbi9NYWtlZmlsZS50YXJn
ZXQKKysrIGIvdGVzdHMvdGNnL2hleGFnb24vTWFrZWZpbGUudGFyZ2V0CkBAIC01NCw2ICs1NCw3
IEBAIEhFWF9URVNUUyArPSBpbnZhbGlkLXNsb3RzCiBIRVhfVEVTVFMgKz0gaW52YWxpZC1lbmNv
ZGluZwogSEVYX1RFU1RTICs9IG11bHRpcGxlLXdyaXRlcwogSEVYX1RFU1RTICs9IHVuYWxpZ25l
ZF9wYworSEVYX1RFU1RTICs9IHVuYWxpZ25lZF9kYXRhCiAKIEhFWF9URVNUUyArPSB0ZXN0X2Fi
cwogSEVYX1RFU1RTICs9IHRlc3RfYml0Y250CkBAIC0xMDgsNiArMTA5LDcgQEAgcHJlZ19hbGlh
czogcHJlZ19hbGlhcy5jIGhleF90ZXN0LmgKIHJlYWRfd3JpdGVfb3ZlcmxhcDogcmVhZF93cml0
ZV9vdmVybGFwLmMgaGV4X3Rlc3QuaAogcmVnX211dDogcmVnX211dC5jIGhleF90ZXN0LmgKIHRl
c3RfcG5ld19qdW1wX2xvYWRzOiB0ZXN0X3BuZXdfanVtcF9sb2Fkcy5jIGhleF90ZXN0LmgKK3Vu
YWxpZ25lZF9kYXRhOiB1bmFsaWduZWRfZGF0YS5jIGhleF90ZXN0LmgKIHVuYWxpZ25lZF9wYzog
dW5hbGlnbmVkX3BjLmMKIAogIyBDb21waWxlIGZvciB2NjYgc28gdGhhdCB0aGUgRUxGIHNlbGVj
dHMgYSB2NjYgQ1BVOyB0aGUgdGVzdCB0aGVuCi0tIAoyLjM0LjEKCg==

