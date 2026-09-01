Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B57D7C61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 17:35:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1SNA-0005aq-MX; Tue, 01 Sep 2026 13:34:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1SN5-0005Yf-NB
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 13:34:08 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1SN4-00081h-9D
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 13:34:07 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681H7WmY3661216
 for <qemu-devel@nongnu.org>; Tue, 1 Sep 2026 17:34:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dmVROyJcOOycMsieHBREEe5BhFjOWBR3dEiwSCpdgWI=; b=g8drnwsmF77ChJ0z
 VPQrDto7z7FbFMpDccQiP2IIttFhyKoviA/MeNLlM67hs0Jtlz+3RislWq6lrvvM
 7dshXoCRieBN7peAM+Rdu0uk/nDiA2C76F4QG5bRO8YjO4Cx+yOZOXuMbpMVDrRl
 Eo6ISYRwsPEdITWszLTkURo/JE5RydPz2PzLeoalr8deY5qL5zre96ZrZYORlLc7
 bFarJmFS6ZX/FWKLr5shBpDnAvyU/HZkM68KJofoNUhkyqTotTkEIySPyMEy6Bn7
 oOv07/DfmADJlD4hHPXAV5fQFucFu77DqZJqA2eHvr1Ithfq4Twe5Cin8Z+Q26lC
 ND59dQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdynt19uk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 17:34:05 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2ce8a76df2dso515655ad.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 10:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788284044; x=1788888844; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dmVROyJcOOycMsieHBREEe5BhFjOWBR3dEiwSCpdgWI=;
 b=dAdBN5IiX62/ad9qtzYNg9uEvT/heGvtgRTCeRjW561Zam7jLjiQhnCkQFd36cCE6N
 BRXOeQEBTqUS8i19PCfbmXj7DDdpWLTUX4NQW4NewKoE/grY3XBppJfoSgKVpmA5lAsl
 8BHjopfXR6maj0eS39RHq7Mx8oRI2wflwHQdP6HnWGSOCoJJj5hSuG8VLzh4OQ2sQaEh
 LBD2/oDJnpo69fiQb+sjvVdp/DwzBvgPffU7pWGG4S46FRoUq7I3kGEKlXM/7bZBRE6l
 5e6tAwvMzL7QDtBT5H4g7dDt8ulyXkIsKg4PlWyk4aaX+fFITa6Q2xpuDcYVg6a+7Xat
 AqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788284044; x=1788888844;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dmVROyJcOOycMsieHBREEe5BhFjOWBR3dEiwSCpdgWI=;
 b=LR5JNEHTmUzPm0AtzmgSCvdnVye6WK1P0z31IArz0KYa/uyNlqepDHNME4dQbR1Uxy
 PyEPGM/zTxH/FDHahe8fmt5rEizaS7hgq3BODBBgLwdzpHw0XVLJN831w5+tI3UatcGN
 cYu6v3+5QAjvAueyX82RO5dRdsrhs5mm8/00nFmCniYct3IgpeNMKOFS/OusoSZwKPrI
 42TwPiGdbgYrpUoSytmXSiWMp/ZpoqHuOVwajlaDFCjmrXMrreSevwR+A5FgaBZZ1JU9
 dWNG3CBjojRcD3k63b2jiyWhMw5IlMZ7ZmgiYAdtPLDteIoBlhpDbqxu8N4bYmvQeoAx
 JNBQ==
X-Gm-Message-State: AFuF++l+kmlcoWIX4U8lrYE4uaZ0yGsj8WdhebhjmjQmfXUWseqKfDyY
 JeEKs4HwjeBi7pbFcUTaUX7EmOY51JME27wxQjlTVay6sFqYwIS/MSUeH2E5J8e+498nrD0+8NY
 pJzOl+IVcfrhKhiw8vjcHjLkaEvZ/vzY2tgpow26PkncZyk3P85g5LhxYY8CvZ7g2oQ==
X-Gm-Gg: AYBFou2uDfrZjdtfDpRdufMWlzmsrhtt3XynsdehYMQ+qKAmdb+A1Lxz2m5Ob5rSKnN
 CsUIf7s2xEWytRypJAn0x4LOvVsei1FrL4y3u1ymCP/k6SFCSHn6EOE9QBeEEfayRL1/r6H89jA
 fIlS99Ecf9OMEVtKw1MK78gIw38JOCD66X46A5iesiYzJ0MwZWlqki+PvNJ7zhLIdFITNyqAGEt
 5KH4PNw6urFxB9Tz5IJ9U/hZljwh5T3+roV7b20jIZx6+/DkwjtGN9G2dT7cWjm+et81pBQtIRx
 f/sTmQI5hB0HI6uPH/nUcLsfpnT5DlipbjS9iWKEX7jgN084nCLtlnEhEXRDVPi8qtV8JT33HT9
 Nq3mvOxyEwhYrW+UhUzonW8DxLHrhPZ8EILXWpM8sf96vSwYq
X-Received: by 2002:a17:903:40c6:b0:2d8:d4d1:3139 with SMTP id
 d9443c01a7336-2d94a935f0amr136198305ad.16.1788284044278; 
 Tue, 01 Sep 2026 10:34:04 -0700 (PDT)
X-Received: by 2002:a17:903:40c6:b0:2d8:d4d1:3139 with SMTP id
 d9443c01a7336-2d94a935f0amr136197675ad.16.1788284043756; 
 Tue, 01 Sep 2026 10:34:03 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3286f95a160sm39702934eec.18.2026.09.01.10.34.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 10:34:02 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
Subject: [PATCH v2 06/11] target/hexagon: gate GPCYCLE guest register reads on
 SSR:CE
Date: Tue,  1 Sep 2026 10:33:48 -0700
Message-Id: <20260901173353.200474-7-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260901173353.200474-1-brian.cain@oss.qualcomm.com>
References: <20260901173353.200474-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE1NSBTYWx0ZWRfXyxa8C7L5BevS
 54SQ4+4IW7nKZC0iwRvHAUCiDfEo9vy5jOU1J+w+ykFKSYM8MHE7kdWHEmCpypWWJNIubJgk1QS
 AfcvzDTZEG8Mws1JtMDIfHmzAzCOErCsAJq6LTI9Mj3uFoTxV0vjXJw3ZJJxbffwoaZs091EoAD
 x2eQdRugkORaslOe0sQC0WLYZvlVPmqAMUeBuk1hLtAja6prrYl/ICNmpGwfuWjdMGWduv1Fe/E
 11L4RsZKA/WAF6k7L8sbCG1xAJx72fTLBOUS7gezo24euttSxwuxpGthXN+9lKyW9c2bid0vZ54
 Ky9YkvGgxm6QkwonUCZtzC3kRjTjJJ+RWE4J3esQZqRXpje7BBwlxK88fLuMxv43hoWZfSf4pth
 RDtx27KqUHHVHZlBc4t5jwapdXyFIlYyI7AQkWrnDBOS0SUnysxzUv7rfjc0nA7qSbWUMcR8hN2
 VjbXGdSQ/M7Bsdlu6jQ==
X-Proofpoint-ORIG-GUID: y6cqke0rQxza1dPzmm_GbMxl8RNE90J4
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE1NSBTYWx0ZWRfX1hk+yA1DZ/4W
 Wi+p1w8cNskwjG8ihma4lRgby2TFdzpNFxMYlkI1dc8GAH5aP5Qedrc9bez9eFLyTWn4VCHk6iq
 66RGC+TNVFRM5b/xmTSnpUmdywXECcs=
X-Authority-Analysis: v=2.4 cv=LfkMLDfi c=1 sm=1 tr=0 ts=6a970c8d cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=xDRi0JrXNLxaQ6-XZMQA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: y6cqke0rQxza1dPzmm_GbMxl8RNE90J4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_05,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010155
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

R1BDWUNMRUxPL0dQQ1lDTEVISSByZWFkIGFzIHplcm8gdW5sZXNzIHRoZSBjeWNsZSBjb3VudGVy
IGlzIGVuYWJsZWQKKFNTUjpDRSksIG1hdGNoaW5nIHRoZSBoYXJkd2FyZS4KClJldmlld2VkLWJ5
OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9zcy5xdWFsY29tbS5jb20+ClNp
Z25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0t
CiB0YXJnZXQvaGV4YWdvbi9jcHUuYyAgICAgICB8IDcgKysrKystLQogdGFyZ2V0L2hleGFnb24v
b3BfaGVscGVyLmMgfCA5ICsrLS0tLS0tLQogMiBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMo
KyksIDkgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LmMgYi90
YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCAwYmJlZmMyZmI4Ny4uMGE2Nzc4NDBiY2IgMTAwNjQ0
Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCkBA
IC04MDksMTQgKzgwOSwxNyBAQCBzdGF0aWMgdm9pZCBoZXhhZ29uX2NwdV9jbGFzc19pbml0KE9i
amVjdENsYXNzICpjLCBjb25zdCB2b2lkICpkYXRhKQogI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZ
CiB1aW50MzJfdCBoZXhhZ29uX2dyZWdfcmVhZChDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMy
X3QgcmVnKQogeworICAgIHVpbnQzMl90IHNzciA9IGVudi0+dF9zcmVnW0hFWF9TUkVHX1NTUl07
CisgICAgaW50IHNzcl9jZSA9IEdFVF9TU1JfRklFTEQoU1NSX0NFLCBzc3IpOworCiAgICAgaWYg
KHJlZyA8PSBIRVhfR1JFR19HMykgewogICAgICAgICByZXR1cm4gZW52LT5ncmVnW3JlZ107CiAg
ICAgfQogICAgIHN3aXRjaCAocmVnKSB7CiAgICAgY2FzZSBIRVhfR1JFR19HUENZQ0xFTE86Ci0g
ICAgICAgIHJldHVybiBoZXhhZ29uX2dldF9zeXNfcGN5Y2xlX2NvdW50X2xvdyhlbnYpOworICAg
ICAgICByZXR1cm4gc3NyX2NlID8gaGV4YWdvbl9nZXRfc3lzX3BjeWNsZV9jb3VudF9sb3coZW52
KSA6IDA7CiAgICAgY2FzZSBIRVhfR1JFR19HUENZQ0xFSEk6Ci0gICAgICAgIHJldHVybiBoZXhh
Z29uX2dldF9zeXNfcGN5Y2xlX2NvdW50X2hpZ2goZW52KTsKKyAgICAgICAgcmV0dXJuIHNzcl9j
ZSA/IGhleGFnb25fZ2V0X3N5c19wY3ljbGVfY291bnRfaGlnaChlbnYpIDogMDsKICAgICBkZWZh
dWx0OgogICAgICAgICBxZW11X2xvZ19tYXNrKExPR19VTklNUCwgInJlYWRpbmcgZ3JlZyAlIiBQ
UklkMzIKICAgICAgICAgICAgICAgICAiIG5vdCB5ZXQgc3VwcG9ydGVkLlxuIiwgcmVnKTsKZGlm
ZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIGIvdGFyZ2V0L2hleGFnb24vb3Bf
aGVscGVyLmMKaW5kZXggMjM4OTRmZjNkMjguLjJjZWExOTI3MjYzIDEwMDY0NAotLS0gYS90YXJn
ZXQvaGV4YWdvbi9vcF9oZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwpA
QCAtMTkxMiwxMyArMTkxMiw4IEBAIHVpbnQ2NF90IEhFTFBFUihncmVnX3JlYWRfcGFpcikoQ1BV
SGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHJlZykKICAgICAgICAgcmV0dXJuICh1aW50NjRf
dCkoZW52LT5ncmVnW3JlZ10pIHwKICAgICAgICAgICAgICAgICgoKHVpbnQ2NF90KShlbnYtPmdy
ZWdbcmVnICsgMV0pKSA8PCAzMik7CiAgICAgfQotICAgIHN3aXRjaCAocmVnKSB7Ci0gICAgY2Fz
ZSBIRVhfR1JFR19HUENZQ0xFTE86Ci0gICAgICAgIHJldHVybiBoZXhhZ29uX2dldF9zeXNfcGN5
Y2xlX2NvdW50KGVudik7Ci0gICAgZGVmYXVsdDoKLSAgICAgICAgcmV0dXJuICh1aW50NjRfdClo
ZXhhZ29uX2dyZWdfcmVhZChlbnYsIHJlZykgfAotICAgICAgICAgICAgICAgKCh1aW50NjRfdCko
aGV4YWdvbl9ncmVnX3JlYWQoZW52LCByZWcgKyAxKSkgPDwgMzIpOwotICAgIH0KKyAgICByZXR1
cm4gKHVpbnQ2NF90KWhleGFnb25fZ3JlZ19yZWFkKGVudiwgcmVnKSB8CisgICAgICAgICAgICgo
dWludDY0X3QpKGhleGFnb25fZ3JlZ19yZWFkKGVudiwgcmVnICsgMSkpIDw8IDMyKTsKIH0KIAog
LyoKLS0gCjIuMzQuMQoK

