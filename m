Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63700C44501
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 15:51:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjfQ9-00010Z-Qa; Tue, 14 Jul 2026 11:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wjfQ7-00010F-VS
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 11:51:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wjfQ5-000150-SS
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 11:51:43 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EEcjEA824481
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 15:51:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JGykux9+eIJ7NwUJM9z+tLu1ERVJ12Ocf9EAomW4Xh8=; b=M5VmGoITh6ZByGES
 FKb/k9hgbPYmDZGHfsNo1oNTsL9TQEc0X2uF4Ydk/Tx4hCdLgRxHF8AMZq8bglHH
 E/kLy1DI8n7O0fwN8Lse881WGfTakXTRlYHz48OMSoGKsq+gEUEZ4b3B9EHcvsia
 U7XeGE5WdctmDA31tqRWFgBdpjVDboDzXZQzaJMx3MOngHCOwB2cn7e+BsXHyOek
 gFgIhxIGnqai60wVjjxPwAkRuAJ582XZiPuuiUevFITLtuDHepJUaj4ZNWLGMi+8
 +FlSPQqYwFTV90naQrLNUCKKEASHkha4LABhhzTp+q1Qh1PDRzyrNgcIuddlps/K
 pOlAKA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdbr4b43s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 15:51:40 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-84a251c2e3eso1705794b3a.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 08:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784044300; x=1784649100; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JGykux9+eIJ7NwUJM9z+tLu1ERVJ12Ocf9EAomW4Xh8=;
 b=VzOst14WN1U7u8nO5x5IOXCMNnerJ3UJZ2YyGfwAtfTFA18mJrImT3ukfUbfB73AmF
 x1r2OijJvFW9egScSEayddmTzzXSxyuXok/pQyNCsVNM2EXpJh/e+GXPNcpOkx29QcHv
 sL36GXHSqPq31acvcO29I9hqmkxtkCOFoelJ/7ls1HeOZQfwY8Npqurdue0cbZyxYuCA
 GQwFAQZ0tJyRpCwlHwCDb84Yujt7AC1BBpheh2VktEjI3RKD0K/bjEv4B3MJ8VEtC3XI
 qtA9Tpte5EXLpj0cspcAqk3iwUvz6Sq7RpG70L6HJZ6tusl7pupe/UkFDzmtV0G8bVZU
 Hb3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784044300; x=1784649100;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JGykux9+eIJ7NwUJM9z+tLu1ERVJ12Ocf9EAomW4Xh8=;
 b=LM+35XAyD7gBZNHpS72NExKfdvcg2hMoaxzDTUCPq+GhjpljtDCWvyBMHHvF4kDPfL
 YBIS/6j2wlNma3uzFj39hJ46I5SmYZdsl4Xf9unG+FhkBGxKPAqTHYULmw/4bae7qZav
 uALbAyehe21Kx2NDguIUTkXn52OYsEuIRgSxE10y3HiMgAYDjPYrjWgIyjpgmhNgdDTC
 NvFwywiradHSpeARjh69Jdcie/NtL1asEXDUs47RjFzs1l/mSGNgBkYbZWlOPeLvmixD
 WBgunc/QVi3x+FsuYl40CFmtIPeoPRh497KI+zKZhzP9StyX7fYztoBKLfhBHNtLdhls
 DK4w==
X-Gm-Message-State: AOJu0Yw/LuQU+0IIKTJAUsiifhbfbFtlscSfMZDqXjbw4aP9EMkgTQP4
 wMMzGaU5IYaWufqAeTyFcnbVijhYFUHQZ9R1dFsXIcbv0tpe1LEhrjCB316zU7k3UCQF7jo3qD/
 w+Ywz2280WuHQ7HoQHa+Y7AbHSMBLAmNmXIEcPxisfa0+or4M/46nH0Z2H8rsd90uLQ==
X-Gm-Gg: AfdE7clrZXHnQoztpqID7bPClpeZA8d47yegt0ptoBcbMGsAAlOvldEhV2gC5MfcPKH
 00I4uyvvVJSp5zpdjg4E48sYl6yeW3cS4uP9gniIuv4nl1L71xr8WWBGkokRu3sFnecawPerT21
 msJ+g5dUa1/KViSnaLp9NOstNwq/5j6jQ0H/zigQimXkLLEbRK9GGh+epWlBgZDXxquVAF8aecv
 63CmLhO1vJdXGaEiNo/7CwVCyB/J3omYIiolX1j0dQxicEHP8EuE76XEHWGnns4n2jN5L46XjzA
 TicxZW+SId1ym1Y8fV4Mm8gdMFu0GCIQdvUmlOYr1viP53qjMqFJeuwn39xxXCeKKo7zu1rDNx0
 FhB3fUWydagupKIKJcWmb+DhYWlmbLPDXau/rP+or5y1BH8zqe6CeNMAc1lo=
X-Received: by 2002:a05:6a21:4516:b0:3ba:d7b0:fcac with SMTP id
 adf61e73a8af0-3c0f085a7fcmr21151103637.5.1784044299595; 
 Tue, 14 Jul 2026 08:51:39 -0700 (PDT)
X-Received: by 2002:a05:6a21:4516:b0:3ba:d7b0:fcac with SMTP id
 adf61e73a8af0-3c0f085a7fcmr21151066637.5.1784044298976; 
 Tue, 14 Jul 2026 08:51:38 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b987fc629sm41343581c88.0.2026.07.14.08.51.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 08:51:38 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: ltaylorsimpson@gmail.com, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 matheus.bernardino@oss.qualcomm.com, Fabiano Rosas <farosas@suse.de>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 philmd@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH 7/7] tests/functional/hexagon: add arch_tests functional test
Date: Tue, 14 Jul 2026 08:51:26 -0700
Message-Id: <20260714155126.3509544-8-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260714155126.3509544-1-brian.cain@oss.qualcomm.com>
References: <20260714155126.3509544-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: AeCTLTOCsR1DVKC9f8-CBF6uoSwPmOJm
X-Proofpoint-ORIG-GUID: AeCTLTOCsR1DVKC9f8-CBF6uoSwPmOJm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE2NCBTYWx0ZWRfX70FycKifgYjL
 i268eUV7AaiInHUy4EQ+LgNnixVy+deh9V7bMcUPz+2rJauwdSVSqR7OlzqNYdAIGKe5zPZefql
 kNTNTessnOfGw3pKrNJNMAEuI3D1ALRsM39l5+gTt93+hs/MaLz0So8gfBBvu4twndfRqJwia3I
 gVP6SzG/D4kdNOKWcdWqtCzo6fxgBErfdiYxjPtfTk2n8ab/FDrcdYTrk2FndNTPzwtmN3FilJg
 H8xyHxyLOS2HS+qr2mN4ErwCy/6cEkwnoiMVllTC7p5NjeiW+LKmTNYNVl4dLKfudLj2P7DjSfb
 DcwEAPjrOZhI0a5W3wstCpJKFdEZmfzQrwjPEislECIkSuNuM645OHQUWGb9qvCDVnsnnadzI71
 HaIyA+8D3n1k1hrv4hx5LMVzDzNCIauCsFnhp3mOksXbuHQI/w4/zaZGjgJp0+6FNVo+BwPWvjj
 3X3Fvhh5XtBF6MCrEiQ==
X-Authority-Analysis: v=2.4 cv=F5hnsKhN c=1 sm=1 tr=0 ts=6a565b0c cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=5vFef2XoAAAA:20 a=EUspDBNiAAAA:8 a=2-CgB73GCJ25MrH1sBkA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE2NCBTYWx0ZWRfX57NKRV2LDXlg
 F15OyTfNMrQM4ikplXCX2RjxFbXG2OXeDkVzin7oSS/Uh0mDhV3mBkPAmseJgE84FnSfmTp3PeA
 I46xD93VTAfQP7Qy4IPC3DaCDsP2KoQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 adultscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140164
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

QWRkIG5ldyB0ZXN0IGNhc2VzIGZyb20gaGV4YWdvbi1hcmNoLXRlc3RzIHRvIGV4ZXJjaXNlIGV4
Y2VwdGlvbnMsCmd1ZXN0IG1vZGUsIGludGVycnVwdCBzdGVlcmluZywgZXRjLgoKU2lnbmVkLW9m
Zi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIE1BSU5U
QUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMSArCiB0ZXN0cy9mdW5j
dGlvbmFsL2hleGFnb24vbWVzb24uYnVpbGQgICAgICAgIHwgIDUgKysKIHRlc3RzL2Z1bmN0aW9u
YWwvaGV4YWdvbi90ZXN0X2FyY2hfdGVzdHMucHkgfCA2NSArKysrKysrKysrKysrKysrKysrKysK
IHRlc3RzL2Z1bmN0aW9uYWwvbWVzb24uYnVpbGQgICAgICAgICAgICAgICAgfCAgMSArCiA0IGZp
bGVzIGNoYW5nZWQsIDcyIGluc2VydGlvbnMoKykKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy9m
dW5jdGlvbmFsL2hleGFnb24vbWVzb24uYnVpbGQKIGNyZWF0ZSBtb2RlIDEwMDc1NSB0ZXN0cy9m
dW5jdGlvbmFsL2hleGFnb24vdGVzdF9hcmNoX3Rlc3RzLnB5CgpkaWZmIC0tZ2l0IGEvTUFJTlRB
SU5FUlMgYi9NQUlOVEFJTkVSUwppbmRleCA4MjAxZTQ4NzAwMC4uYTliMTM0YjMyM2UgMTAwNjQ0
Ci0tLSBhL01BSU5UQUlORVJTCisrKyBiL01BSU5UQUlORVJTCkBAIC0xMzYxLDYgKzEzNjEsNyBA
QCBGOiBody9oZXhhZ29uLwogRjogaW5jbHVkZS9ody9oZXhhZ29uLwogRjogY29uZmlncy9kZXZp
Y2VzL2hleGFnb24tc29mdG1tdS9kZWZhdWx0Lm1hawogRjogZG9jcy9zeXN0ZW0vaGV4YWdvbi8K
K0Y6IHRlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi8KIEY6IGRvY3MvZGV2ZWwvaGV4YWdvbi1zeXMu
cnN0CiAKIExvb25nQXJjaCBNYWNoaW5lcwpkaWZmIC0tZ2l0IGEvdGVzdHMvZnVuY3Rpb25hbC9o
ZXhhZ29uL21lc29uLmJ1aWxkIGIvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL21lc29uLmJ1aWxk
Cm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAwLi4yYjVhMWE4ZjI2NAotLS0g
L2Rldi9udWxsCisrKyBiL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi9tZXNvbi5idWlsZApAQCAt
MCwwICsxLDUgQEAKKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIK
KwordGVzdHNfaGV4YWdvbl9zeXN0ZW1fdGhvcm91Z2ggPSBbCisgICdhcmNoX3Rlc3RzJywKK10K
ZGlmZiAtLWdpdCBhL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X2FyY2hfdGVzdHMucHkg
Yi90ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9hcmNoX3Rlc3RzLnB5Cm5ldyBmaWxlIG1v
ZGUgMTAwNzU1CmluZGV4IDAwMDAwMDAwMDAwLi4wMDg4MjJkNWU1YgotLS0gL2Rldi9udWxsCisr
KyBiL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X2FyY2hfdGVzdHMucHkKQEAgLTAsMCAr
MSw2NSBAQAorIyEvdXNyL2Jpbi9lbnYgcHl0aG9uMworIworIyBDb3B5cmlnaHQgKGMpIFF1YWxj
b21tIFRlY2hub2xvZ2llcywgSW5jLiBhbmQvb3IgaXRzIHN1YnNpZGlhcmllcy4KKyMKKyMgU1BE
WC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIKKworaW1wb3J0IG9zCitmcm9t
IHFlbXVfdGVzdCBpbXBvcnQgUWVtdVN5c3RlbVRlc3QsIEFzc2V0Citmcm9tIHFlbXVfdGVzdC5j
bWQgaW1wb3J0IHdhaXRfZm9yX2NvbnNvbGVfcGF0dGVybgorCisKK2NsYXNzIEFyY2hUZXN0c1Vh
cnQoUWVtdVN5c3RlbVRlc3QpOgorICAgICIiIgorICAgIEhleGFnb24gYXJjaGl0ZWN0dXJlIHZl
cmlmaWNhdGlvbiB0ZXN0cworCisgICAgVGhlc2UgYXJlIGJhcmUtbWV0YWwgdGVzdHMgZnJvbSBo
ZXhhZ29uLWFyY2gtdGVzdHMgdGhhdCBleGVyY2lzZQorICAgIHN5c3RlbSBmdW5jdGlvbmFsaXR5
LgorCisgICAgVGVzdHMgb3V0cHV0IHJlc3VsdHMgdmlhIFVBUlQuCisgICAgIiIiCisgICAgdGlt
ZW91dCA9IDYwCisKKyAgICBBU1NFVF9UQVJCQUxMID0gQXNzZXQoCisgICAgICAgICJodHRwczov
L2dpdGh1Yi5jb20vcXVhbGNvbW0vcWVtdS1oZXhhZ29uLXRlc3RpbmcvcmVsZWFzZXMvIgorICAg
ICAgICAiZG93bmxvYWQvdjAuMi41L2FyY2hfdGVzdHNfdWFydC50YXIuZ3oiLAorICAgICAgICAi
ZWRiNGYzN2I4NzdhM2E3MmEwZTEwOTIwNDc3NDU4YTQzYjQwMDQ1ZDM0Mzk4ZmVlOGNiNzYzZmVm
ZDM0MmY0ZiIsCisgICAgKQorCisgICAgZGVmIHJ1bl91YXJ0X3Rlc3Qoc2VsZiwgdGVzdF9uYW1l
OiBzdHIsCisgICAgICAgICAgICAgICAgICAgICAgbWFjaGluZTogc3RyID0gInZpcnQiKSAtPiBO
b25lOgorICAgICAgICAiIiIKKyAgICAgICAgUnVuIGFuIGFyY2ggdGVzdCBiaW5hcnkgYW5kIHZl
cmlmeSBQQVNTIHZpYSBVQVJUIGNvbnNvbGUgb3V0cHV0LgorICAgICAgICAiIiIKKyAgICAgICAg
c2VsZi5zZXRfbWFjaGluZShtYWNoaW5lKQorICAgICAgICBzZWxmLmFyY2hpdmVfZXh0cmFjdChz
ZWxmLkFTU0VUX1RBUkJBTEwpCisgICAgICAgIHRhcmdldF9iaW4gPSBvcy5wYXRoLmpvaW4oc2Vs
Zi53b3JrZGlyLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICdhcmNoX3Rlc3Rz
X3VhcnRfcGFja2FnZScsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJ2Jpbics
IHRlc3RfbmFtZSkKKyAgICAgICAgc2VsZi52bS5zZXRfY29uc29sZSgpCisgICAgICAgIHNlbGYu
c2V0X3ZtX2FyZygiLWRpc3BsYXkiLCAibm9uZSIpCisgICAgICAgIHNlbGYuc2V0X3ZtX2FyZygi
LWtlcm5lbCIsIHRhcmdldF9iaW4pCisgICAgICAgIHNlbGYudm0ubGF1bmNoKCkKKyAgICAgICAg
d2FpdF9mb3JfY29uc29sZV9wYXR0ZXJuKHNlbGYsICJQQVNTIikKKworICAgIGRlZiB0ZXN0X2V4
Y2VwdGlvbnMoc2VsZikgLT4gTm9uZToKKyAgICAgICAgIiIiVGVzdHMgZXhjZXB0aW9uIGRlbGl2
ZXJ5IGZvciB0cmFwIGluc3RydWN0aW9ucywgcHJpdmlsZWdlCisgICAgICAgIHZpb2xhdGlvbnMs
IGFuZCB2ZXJpZmllcyBTU1IgY2F1c2UgY29kZXMgYW5kIEVMUiB2YWx1ZXMuCisgICAgICAgICIi
IgorICAgICAgICBzZWxmLnJ1bl91YXJ0X3Rlc3QoInRlc3RfZXhjZXB0aW9ucyIpCisKKyAgICBk
ZWYgdGVzdF9ndWVzdF9tb2RlKHNlbGYpIC0+IE5vbmU6CisgICAgICAgICIiIlRlc3RzIGd1ZXN0
IG1vZGUgZW50cnkvZXhpdCB2aWEgQ0NSIGNvbmZpZ3VyYXRpb24sIHZlcmlmeWluZworICAgICAg
ICBHU1IgZmllbGRzLCBHRUxSLCBhbmQgZ3Vlc3QgZXZlbnQgdmVjdG9yIHRhYmxlIGRpc3BhdGNo
LgorICAgICAgICAiIiIKKyAgICAgICAgc2VsZi5ydW5fdWFydF90ZXN0KCJ0ZXN0X2d1ZXN0X21v
ZGUiKQorCisgICAgZGVmIHRlc3RfaW50X3N0ZWVyaW5nKHNlbGYpIC0+IE5vbmU6CisgICAgICAg
ICIiIlRlc3RzIGludGVycnVwdCBzdGVlcmluZyB2aWEgcHJpb3JpdHktYmFzZWQgcm91dGluZyB0
bworICAgICAgICBzcGVjaWZpYyB0aHJlYWRzIHVzaW5nIFNUSUQgcHJpb3JpdHkgYW5kIGlhc3Np
Z253LgorICAgICAgICAiIiIKKyAgICAgICAgc2VsZi5ydW5fdWFydF90ZXN0KCJ0ZXN0X2ludF9z
dGVlcmluZyIpCisKKworaWYgX19uYW1lX18gPT0gIl9fbWFpbl9fIjoKKyAgICBRZW11U3lzdGVt
VGVzdC5tYWluKCkKZGlmZiAtLWdpdCBhL3Rlc3RzL2Z1bmN0aW9uYWwvbWVzb24uYnVpbGQgYi90
ZXN0cy9mdW5jdGlvbmFsL21lc29uLmJ1aWxkCmluZGV4IGMxNTgxOTdjNGI3Li5jNzM2MmRkMDBl
ZiAxMDA2NDQKLS0tIGEvdGVzdHMvZnVuY3Rpb25hbC9tZXNvbi5idWlsZAorKysgYi90ZXN0cy9m
dW5jdGlvbmFsL21lc29uLmJ1aWxkCkBAIC0xNCw2ICsxNCw3IEBAIHN1YmRpcignYWFyY2g2NCcp
CiBzdWJkaXIoJ2FscGhhJykKIHN1YmRpcignYXJtJykKIHN1YmRpcignYXZyJykKK3N1YmRpcign
aGV4YWdvbicpCiBzdWJkaXIoJ2hwcGEnKQogc3ViZGlyKCdpMzg2JykKIHN1YmRpcignbG9vbmdh
cmNoNjQnKQotLSAKMi4zNC4xCgo=

