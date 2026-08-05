Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4243FC55ABA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 16:53:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrerF-0005uz-C0; Wed, 05 Aug 2026 12:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wrer8-0005tf-EV
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 12:52:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wrer6-00035f-Qx
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 12:52:38 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 675FVTAo3332386
 for <qemu-devel@nongnu.org>; Wed, 5 Aug 2026 16:52:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8vW5kKWDW3NvUWM1fxGl/woO0vI8iMp3ePv+qqFfRyg=; b=NH+r8JRFpXVjtahA
 BfNbS3iYyCGlkqumRsps9pS7So8xGmwxtUPQRh8eXXerdN3xwauSJ+hVgNNX0Cit
 yfaJHx6Y3hvmaPUZzN1yxm4uvVGW8Frw/iW84PdxxLCVIRIfScRxvvtserqQjfSX
 2K7syB40lgtHIpLwymhfxiIqbvxts8X7zxEFTWuMgk5edhM8gX+DHl/Z55N1j8tU
 zkygdjPYUpf5WmQ9UHK0NLf+2c5qqNjoz+Qt7Q9UOBK18lPJG8VQmJda2dR+Cfnr
 ZOuJ3FYA8rap5qqeZYfnH9JXcVmHbwdiBHkIHWFJf8npLtmrbVoIJl6yiMs8jgm6
 GvjKPw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv2c0a2x3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 16:52:35 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38e7ff7b375so1354791a91.1
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 09:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785948755; x=1786553555; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8vW5kKWDW3NvUWM1fxGl/woO0vI8iMp3ePv+qqFfRyg=;
 b=Z/NNtDu/x/EKhYc8FVUyLpdGp2HvlYpe5qMk5AO2qOUGm53dkmBSesf1buVH4+M3v2
 toTkHAMSMImItHXBRqWbh5CkpPmt1hQKsV7smzPg3auEr/6mbQDhE1U6N1ZmY6kWGHwc
 iOXTMznYGg0oBddaE0yLzJRtmcyyAC7xVg7fzgeoJ4o2ZZ6C2nLWVm0kMYuXUzWxEtAz
 osZgKwQwXCJTyVdzTe/zrkHsnXVdXek9DUY9+HnhFKCSFnhJITv9891VsZQUEAY1tnJv
 4vAg+kWR8vmTeLtOhGr0vYuZCePXxbEoHuD+yl3STwDq6v/WnjXc4/R1q1ZOzYrv+4y8
 J/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785948755; x=1786553555;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8vW5kKWDW3NvUWM1fxGl/woO0vI8iMp3ePv+qqFfRyg=;
 b=sx+rtrFiQKuo4/WP+32TcyIpiawlm8v7Qc0Xw2KJj2gS3c5g7Q8egs41nWMYHjblSE
 eL5kaBak1UHLGcuA5FW/gHUlS55YJnj895E68WZAx8oe8TOcxUaQsp8sZGsAEVWQn6Zb
 a1JzcKSrbVbGqBww7/ayNpjZaXNlipqGF4nvzfDj/ACAAO/RrVx2W1M/aGqtL1GM8r/B
 kuFE9J/nzrPyG/ogjKMIAhl+YECp9JwiAd8r7MXu4IGf+3LzisO3lodCbXVl6wA+nyiI
 PkAN+gZrag8BIPiqq3jgO8rMS0mOvhfTG4Ux4B+rUMWVGq3V5q9Dw3xlexMsP4rV8pZs
 SFmg==
X-Gm-Message-State: AOJu0Yx6RnTcREJqLs68OcSv//r/8IEPSjOkFYi+XTuz/3u5WAURkrqC
 sZXjQ1JaUYW8oglokU9KEKu20gDyWpaWoX0wY3kSRl/sRCnbWQEn4zlZy63apzvHfI+qqJruvbm
 5/enettmPS9OWYRFZlveVnLv6KOmSmBg++S32AZhHblN5aOcH+DPcm7tExaGCThoDKA==
X-Gm-Gg: AR+sD10VUPRDnhW13YiVUP69d2DydhX7PsnysFKZvjhriuefdV8vXfhUXWhcxdsmP7o
 7UG5pC+ef2LRwbDAQxN4h2I6kqCdMcaSgLatkXXI90B1ukDAvVhv4PD1RjbyguL9vXkQK5r7tPp
 NzZUYUJBR2z9gWr+TyPUGO9/gc8R9vt5NFVvzkTrE1KFmcuD1MeFVHIpT0SL/NgBDOcnif1ExYl
 OOsKALF5fh2ghGdjArrpxdfo4Z9H+aR2FOsoGhiK9aKvsDnf/Rt4XTL9+07vOybCMci0aE/sFgR
 Tueb+sJtz/8b3yMpj9He3kvHPeG1btneI/u05nWR+iTAr4CqZnP/ziwrf3qbkaf4jpb9jvxhv95
 acb+2VJGRItkXu3Gq8CMl+ChlMBmr/KzhvALZFg8dXJIRaLK8
X-Received: by 2002:a17:90b:2248:b0:37f:c28a:de61 with SMTP id
 98e67ed59e1d1-3903c5ea04cmr7477082a91.17.1785948754894; 
 Wed, 05 Aug 2026 09:52:34 -0700 (PDT)
X-Received: by 2002:a17:90b:2248:b0:37f:c28a:de61 with SMTP id
 98e67ed59e1d1-3903c5ea04cmr7477022a91.17.1785948754386; 
 Wed, 05 Aug 2026 09:52:34 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31586402e53sm26429356eec.11.2026.08.05.09.52.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 09:52:33 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com, richard.henderson@linaro.org
Subject: [PATCH 5/6] target/hexagon: add GVec overrides for HVX vector average
Date: Wed,  5 Aug 2026 09:52:24 -0700
Message-Id: <20260805165225.3117924-6-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260805165225.3117924-1-brian.cain@oss.qualcomm.com>
References: <20260805165225.3117924-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: 6ttNsx7b3m-fziPSSCgghFFMhyAsuOYD
X-Authority-Analysis: v=2.4 cv=aOfAb79m c=1 sm=1 tr=0 ts=6a736a53 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=capXNgF54ZM412bi96QA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDEzOCBTYWx0ZWRfX7ZxXqoLkVDH+
 wATkbnRihmLv548zUSxVlGO1xb6alDwkBRkBWhaDNRE7yC2WP8IFYu8iPgEM8Vhm2OpD1omKsYp
 RL3Oh6zH3JyXaPpMEaO3c8dil0fF/48=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDEzOCBTYWx0ZWRfXwDpD5JvLR4Pb
 37RVC7AHlQufghCv/j9LfXfE8Fl6A0giTDpDYaM1H0VQ11BNDBKwMXvgIQmbRmwEtU9PYUQ+LMF
 izQLi7xWpJkIubyqoojRrNnUizTExE5A7L3BlCqbHIl5v+piADVxtpNsadvn8eAOqg33KKigZ5O
 Tmxpo0gK5cVtTUEQOe+gleLOsQdgiyqB5ooQEjPWO4ieNoSqcj9LwaTlk6/f77BuAEoTPMc2T5o
 VK7XUCz9Q8I06b/DNCJgb2FzADD70b85rM99U1oZSD36y4QkR6qDzIgzExs0/d4QbtQH9ZLb0qF
 1KEesk3zgpZWOGVv6gNXN5Hv589PmOYTu5v5zHHRXA3OLB1NjOtU4RCZDCn02H7iLGNi1GJr0A8
 y7s6FGHza8WGj7goN4qb7JnobC5fPnY9MBAVPwxhJ9kpcmKgi4MaRnehmMEhNHgGbj0cQWcF12L
 icHlgl25hH8XMjE42Hw==
X-Proofpoint-GUID: 6ttNsx7b3m-fziPSSCgghFFMhyAsuOYD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_05,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 clxscore=1015 phishscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050138
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

U2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgot
LS0KIHRhcmdldC9oZXhhZ29uL2dlbl90Y2dfaHZ4LmggfCA2MiArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA2MiBpbnNlcnRpb25zKCspCgpkaWZm
IC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19odnguaCBiL3RhcmdldC9oZXhhZ29uL2dl
bl90Y2dfaHZ4LmgKaW5kZXggM2NiNTJjNzYxYWUuLjk3YzM3M2MxMGJmIDEwMDY0NAotLS0gYS90
YXJnZXQvaGV4YWdvbi9nZW5fdGNnX2h2eC5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2dlbl90Y2df
aHZ4LmgKQEAgLTM1NSw2ICszNTUsNjggQEAgc3RhdGljIGlubGluZSB2b2lkIGFzc2VydF92aGlz
dF90bXAoRGlzYXNDb250ZXh0ICpjdHgpCiAjZGVmaW5lIGZHRU5fVENHX1Y2X3ZhYnNkaWZmdyhT
SE9SVENPREUpIFwKICAgICBmR0VOX1RDR19WRUNfQUJTRElGRihNT18zMiwgdGNnX2dlbl9ndmVj
X3NtYXgsIHRjZ19nZW5fZ3ZlY19zbWluKQogCisjZGVmaW5lIGZHRU5fVENHX1ZFQ19BVkcoVkVD
RSwgU0hJRlRfRk4pIFwKKyAgICBkbyB7IFwKKyAgICAgICAgaW50cHRyX3QgdG1wb2ZmID0gb2Zm
c2V0b2YoQ1BVSGV4YWdvblN0YXRlLCB2dG1wKTsgXAorICAgICAgICB0Y2dfZ2VuX2d2ZWNfYW5k
KE1PXzY0LCB0bXBvZmYsIFZ1Vl9vZmYsIFZ2Vl9vZmYsIFwKKyAgICAgICAgICAgICAgICAgICAg
ICAgICBWRUNUT1JfU0laRV9CWVRFLCBWRUNUT1JfU0laRV9CWVRFKTsgXAorICAgICAgICB0Y2df
Z2VuX2d2ZWNfeG9yKE1PXzY0LCBWZFZfb2ZmLCBWdVZfb2ZmLCBWdlZfb2ZmLCBcCisgICAgICAg
ICAgICAgICAgICAgICAgICAgVkVDVE9SX1NJWkVfQllURSwgVkVDVE9SX1NJWkVfQllURSk7IFwK
KyAgICAgICAgU0hJRlRfRk4oVkVDRSwgVmRWX29mZiwgVmRWX29mZiwgMSwgXAorICAgICAgICAg
ICAgICAgICBWRUNUT1JfU0laRV9CWVRFLCBWRUNUT1JfU0laRV9CWVRFKTsgXAorICAgICAgICB0
Y2dfZ2VuX2d2ZWNfYWRkKFZFQ0UsIFZkVl9vZmYsIHRtcG9mZiwgVmRWX29mZiwgXAorICAgICAg
ICAgICAgICAgICAgICAgICAgIFZFQ1RPUl9TSVpFX0JZVEUsIFZFQ1RPUl9TSVpFX0JZVEUpOyBc
CisgICAgfSB3aGlsZSAoMCkKKworI2RlZmluZSBmR0VOX1RDR19WNl92YXZndWIoU0hPUlRDT0RF
KSBcCisgICAgZkdFTl9UQ0dfVkVDX0FWRyhNT184LCB0Y2dfZ2VuX2d2ZWNfc2hyaSkKKworI2Rl
ZmluZSBmR0VOX1RDR19WNl92YXZndWgoU0hPUlRDT0RFKSBcCisgICAgZkdFTl9UQ0dfVkVDX0FW
RyhNT18xNiwgdGNnX2dlbl9ndmVjX3NocmkpCisKKyNkZWZpbmUgZkdFTl9UQ0dfVjZfdmF2Z3V3
KFNIT1JUQ09ERSkgXAorICAgIGZHRU5fVENHX1ZFQ19BVkcoTU9fMzIsIHRjZ19nZW5fZ3ZlY19z
aHJpKQorCisjZGVmaW5lIGZHRU5fVENHX1Y2X3ZhdmdiKFNIT1JUQ09ERSkgXAorICAgIGZHRU5f
VENHX1ZFQ19BVkcoTU9fOCwgdGNnX2dlbl9ndmVjX3NhcmkpCisKKyNkZWZpbmUgZkdFTl9UQ0df
VjZfdmF2Z2goU0hPUlRDT0RFKSBcCisgICAgZkdFTl9UQ0dfVkVDX0FWRyhNT18xNiwgdGNnX2dl
bl9ndmVjX3NhcmkpCisKKyNkZWZpbmUgZkdFTl9UQ0dfVjZfdmF2Z3coU0hPUlRDT0RFKSBcCisg
ICAgZkdFTl9UQ0dfVkVDX0FWRyhNT18zMiwgdGNnX2dlbl9ndmVjX3NhcmkpCisKKyNkZWZpbmUg
ZkdFTl9UQ0dfVkVDX0FWR1JORChWRUNFLCBTSElGVF9GTikgXAorICAgIGRvIHsgXAorICAgICAg
ICBpbnRwdHJfdCB0bXBvZmYgPSBvZmZzZXRvZihDUFVIZXhhZ29uU3RhdGUsIHZ0bXApOyBcCisg
ICAgICAgIHRjZ19nZW5fZ3ZlY19vcihNT182NCwgdG1wb2ZmLCBWdVZfb2ZmLCBWdlZfb2ZmLCBc
CisgICAgICAgICAgICAgICAgICAgICAgICBWRUNUT1JfU0laRV9CWVRFLCBWRUNUT1JfU0laRV9C
WVRFKTsgXAorICAgICAgICB0Y2dfZ2VuX2d2ZWNfeG9yKE1PXzY0LCBWZFZfb2ZmLCBWdVZfb2Zm
LCBWdlZfb2ZmLCBcCisgICAgICAgICAgICAgICAgICAgICAgICAgVkVDVE9SX1NJWkVfQllURSwg
VkVDVE9SX1NJWkVfQllURSk7IFwKKyAgICAgICAgU0hJRlRfRk4oVkVDRSwgVmRWX29mZiwgVmRW
X29mZiwgMSwgXAorICAgICAgICAgICAgICAgICBWRUNUT1JfU0laRV9CWVRFLCBWRUNUT1JfU0la
RV9CWVRFKTsgXAorICAgICAgICB0Y2dfZ2VuX2d2ZWNfc3ViKFZFQ0UsIFZkVl9vZmYsIHRtcG9m
ZiwgVmRWX29mZiwgXAorICAgICAgICAgICAgICAgICAgICAgICAgIFZFQ1RPUl9TSVpFX0JZVEUs
IFZFQ1RPUl9TSVpFX0JZVEUpOyBcCisgICAgfSB3aGlsZSAoMCkKKworI2RlZmluZSBmR0VOX1RD
R19WNl92YXZndWJybmQoU0hPUlRDT0RFKSBcCisgICAgZkdFTl9UQ0dfVkVDX0FWR1JORChNT184
LCB0Y2dfZ2VuX2d2ZWNfc2hyaSkKKworI2RlZmluZSBmR0VOX1RDR19WNl92YXZndWhybmQoU0hP
UlRDT0RFKSBcCisgICAgZkdFTl9UQ0dfVkVDX0FWR1JORChNT18xNiwgdGNnX2dlbl9ndmVjX3No
cmkpCisKKyNkZWZpbmUgZkdFTl9UQ0dfVjZfdmF2Z3V3cm5kKFNIT1JUQ09ERSkgXAorICAgIGZH
RU5fVENHX1ZFQ19BVkdSTkQoTU9fMzIsIHRjZ19nZW5fZ3ZlY19zaHJpKQorCisjZGVmaW5lIGZH
RU5fVENHX1Y2X3Zhdmdicm5kKFNIT1JUQ09ERSkgXAorICAgIGZHRU5fVENHX1ZFQ19BVkdSTkQo
TU9fOCwgdGNnX2dlbl9ndmVjX3NhcmkpCisKKyNkZWZpbmUgZkdFTl9UQ0dfVjZfdmF2Z2hybmQo
U0hPUlRDT0RFKSBcCisgICAgZkdFTl9UQ0dfVkVDX0FWR1JORChNT18xNiwgdGNnX2dlbl9ndmVj
X3NhcmkpCisKKyNkZWZpbmUgZkdFTl9UQ0dfVjZfdmF2Z3dybmQoU0hPUlRDT0RFKSBcCisgICAg
ZkdFTl9UQ0dfVkVDX0FWR1JORChNT18zMiwgdGNnX2dlbl9ndmVjX3NhcmkpCisKIC8qIFZlY3Rv
ciBzaGlmdCByaWdodCAtIHZhcmlvdXMgZm9ybXMgKi8KICNkZWZpbmUgZkdFTl9UQ0dfVjZfdmFz
cmgoU0hPUlRDT0RFKSBcCiAgICAgZG8geyBcCi0tIAoyLjM0LjEKCg==

