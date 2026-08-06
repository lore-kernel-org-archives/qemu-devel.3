Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7BE0C55ABA
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 04:29:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrphs-0002sq-DF; Thu, 06 Aug 2026 00:27:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wrphq-0002sS-0s
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 00:27:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wrpho-0003Dv-6n
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 00:27:45 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 675NbDZv267108
 for <qemu-devel@nongnu.org>; Thu, 6 Aug 2026 04:27:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vyFm6rtZZeS2n/g9pNabBjWQ5XefV0jnC61R5IL9YVU=; b=nihn8nhkJFwrvX99
 u7L6T95neuTJGogmOYbsbRh0mHmhyuhaO9Z/7iDHwXOy47mb3D1MyRjMfURJd3NP
 JY3sFEwBQ1p03N1HpqczVXVEKph4SQWvfM7D0+0hDXsnRE8rBOJDRbfrAdKHRWOr
 Au4xnMkb6T6b15fe8q9swDQaDk5nEds7NFNTBjDB4obICVSJEaNZ6JwpMRUr94uC
 GaAbrZ0iXa9c+y7HDNHX1pVKEDdsW/6Xz1Q3s48Jvdhooq3dzrM5KiqT8yAND920
 qSzsEGelbYQmQpy40wEnagRkzBuoNrDINNmT/qW4q4zcJ/vbaAEX8mryGYDUlZ2S
 8AOz5Q==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv3w6c1je-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 04:27:42 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cb5bdd8450dso1147784a12.0
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 21:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785990462; x=1786595262; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vyFm6rtZZeS2n/g9pNabBjWQ5XefV0jnC61R5IL9YVU=;
 b=GE4XD+4Wfx85cNF+BGDzOz4kJTksuienrYaPTs3R0kt+AA4VbFrE55H6B+UGFAHoKm
 zzbI0eGK+J860vuJIGKJ2hWipMgIHOAT0lHuCsZaSPcpKdBmMYZ8SiWDXRy6+L5RimLz
 JIuvcdInzqk1GCgiigChCXj/mQKN+eIu3sdyO/GqOqhWi902DRdEpCfe+EF7zGm9pvPW
 2kTgiFhui/LeWRJWTXUkho9VXWh4MaMR0GIkLA77X6wHzIVgHyXLV1WrOmZGmRq0L6CF
 B4QAw1BFetMxi8oLiTvGLK4Di+CyTSKXih69+wd4gEr3cmNEi3FB+2Mxx/EEoxbzDq4X
 Lopw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785990462; x=1786595262;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vyFm6rtZZeS2n/g9pNabBjWQ5XefV0jnC61R5IL9YVU=;
 b=rhLaH0HNvRQUL6AInnRoCvluD25o7ps9Y/zmx2wr7BkK+Z5SgGROOEvZdsCL4qweoe
 LNooh0FqBSazIzm/otLDKutDlra+6QzYMkiRFSbeHGJYfdRiFZ7rkaCI6P8HPx7S2C/Z
 3KSKFTTK67wQR29+jfJD7/GttBD7Lh1nx21b4Rf3Sr0LNcsN5aM/NbG04vnSi5LEjUIC
 KpQKSppSNbOwIEzGL8xTjqBfBKlFZsPYSjdDNI2n2Z4ZEZIKgGRIyIvBk25yKstbe4pu
 ms9KwffYRUs1e8gS5j7gYAtCRNLy3TC1m30WnjDpPOH90sTgi9v5JNoGg/3YvOcl1Smk
 uCoQ==
X-Gm-Message-State: AOJu0YznauU8iKFxPMKujkpAf97QaGQo7uAx6Y1bzBaO9FXYyKKwhZix
 IR+yA+nuZUD91nd2+mIAZFr8laWIZ+0+LPnYsCdrmkn9o3YDvpGn351IZttWQeCqKnMkRBRf1bF
 1gunciXC/yRuKb4tGdinG14py4olun7PXUKUGtlZnxPZ3h80DDWEb9UZiKNYctVr8vw==
X-Gm-Gg: AR+sD13kIZBytAwusiDfqWGCAnQqBkD/3AsePPS0mE3VArSvBQizdyN/2Tpz887fCXF
 yp7wn5JhS687shCiNWECPi3dmK3BSE79fTCzTQUHK4AaaVnx5SXPpsDJJtryiz1LV74aLDdSl48
 mj8JWyBmlCnTM9MuBHtBB5upUumZBRkVcfdagViOvD7yZ02eFZ6sDVwYRzBi/erJAVE+z3lMdlW
 Z94OIa2RrDGx6iCB5L1MKLdnrw0bVe+HoOjtOMSgrs+piTkoUXv5Cr/5QW1f+QjPaojo1x3m4uT
 /QhP59BkM4Dh7EagWZyeLR5GxxHte+ZC2EJl5D1OXsiG2x5lPatlPumpgzG/zjDH8st+pfeBxCM
 8YuAu1qZhG+JePS2wz9UqeztlHkYDSqSdDOSgnc4lANx6Xy/0
X-Received: by 2002:a05:6a21:329e:b0:3b5:489c:7bb5 with SMTP id
 adf61e73a8af0-3cb85f06883mr13779902637.28.1785990462209; 
 Wed, 05 Aug 2026 21:27:42 -0700 (PDT)
X-Received: by 2002:a05:6a21:329e:b0:3b5:489c:7bb5 with SMTP id
 adf61e73a8af0-3cb85f06883mr13779873637.28.1785990461810; 
 Wed, 05 Aug 2026 21:27:41 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fca926c0bsm19572628c88.14.2026.08.05.21.27.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 21:27:40 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 matheus.bernardino@oss.qualcomm.com,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v5 11/18] hw/hexagon/virt: add l2vic interrupt-controller and
 virtio-mmio FDT nodes
Date: Wed,  5 Aug 2026 21:27:16 -0700
Message-Id: <20260806042723.3785369-12-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260806042723.3785369-1-brian.cain@oss.qualcomm.com>
References: <20260806042723.3785369-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: C9q9GtcpxJFDW-EL5cHISBrBpP2-FEJl
X-Proofpoint-ORIG-GUID: C9q9GtcpxJFDW-EL5cHISBrBpP2-FEJl
X-Authority-Analysis: v=2.4 cv=a48AM0SF c=1 sm=1 tr=0 ts=6a740d3e cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=a15GVhKgg4D0RywPxTcA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDAzMCBTYWx0ZWRfXx2xTzZ1udiZm
 XMwSX6jjjwkUnaNMIszDVKK0M9QoMt0hlkAP9yVW/rqWm8wMBz4V3ol7VfpP3JGtU0igUdc2a6K
 kaHJ7SLeUuGIMFK892ECDi+ZlEK/l1A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDAzMCBTYWx0ZWRfX9Uj6Ehaqa3bu
 TEt/p9m7a4tOv80SvGVQzXbylfgF9AN7vLAhXwhW6pl5oJuOAFpKNh7EnoKKF58QqAF/yRBjYRv
 yzL9uKq1XSnmjcWXAkNAPOmInGXrmbSo2n1uPEs6GcMXOsB6s9wwwLNaq2UapiUrrZxkd4CGMdI
 nQNlw4Z6v85ALFqcKtbZK7YgNog180lr4n1EKGep72WDh+IXS+MIYlkPEdvCQpWWZSs0gkl1Yen
 PmzGmjDyZEjG3RhBBWlR3G5eDEnQ4ywZXoNXiqHL100LAlpbUHCgF7t5hWCLTg4GarzcCQLOeT4
 lFM1T85z45QdjXTlTYuaAFIrzPSvWn3ZZOfAT4jr8JLeRmHdT+b3auzeRKYRfuaaDlpcrMdjfqo
 CpFLYNaR7cDj5Dvu7Z57dyXFx9Hx4udh6jbMAVpxNCL/7OIhEX/4ximEoMmLvnMr5K5ATZ/oNm5
 pxxba/D6C0xmH2KGIiA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060030
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

RXhwb3NlIGwydmljIGFzIGEgZGV2aWNlLXRyZWUgaW50ZXJydXB0LWNvbnRyb2xsZXIgbm9kZSBh
bmQgcmVmZXJlbmNlCml0IHZpYSBpbnRlcnJ1cHQtcGFyZW50LCBzbyBndWVzdCBrZXJuZWxzIGNh
biBkaXNjb3ZlciB0aGUgdmlydGlvLW1taW8KdHJhbnNwb3J0cy4KClJldmlld2VkLWJ5OiBQaWVy
cmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1v
ZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiBody9o
ZXhhZ29uL3ZpcnQuYyB8IDQzICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrLS0KIDEgZmlsZSBjaGFuZ2VkLCA0MSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL2h3L2hleGFnb24vdmlydC5jIGIvaHcvaGV4YWdvbi92aXJ0LmMKaW5kZXgg
ZmYwNzcwY2ZjNDYuLmVhMjBlYTNjNTBhIDEwMDY0NAotLS0gYS9ody9oZXhhZ29uL3ZpcnQuYwor
KysgYi9ody9oZXhhZ29uL3ZpcnQuYwpAQCAtNzUsNiArNzUsMzAgQEAgc3RhdGljIHZvaWQgY3Jl
YXRlX2ZkdChIZXhhZ29uVmlydE1hY2hpbmVTdGF0ZSAqdm1zKQogICAgIHFlbXVfZmR0X3NldHBy
b3AoZmR0LCAiL2Nob3NlbiIsICJybmctc2VlZCIsIHJuZ19zZWVkLCBzaXplb2Yocm5nX3NlZWQp
KTsKIH0KIAorc3RhdGljIGludDMyX3QgZmR0X2FkZF9sMnZpYyhIZXhhZ29uVmlydE1hY2hpbmVT
dGF0ZSAqdm1zLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBzdHJ1Y3QgaGV4
YWdvbl9tYWNoaW5lX2NvbmZpZyAqbV9jZmcpCit7CisgICAgTWFjaGluZVN0YXRlICptcyA9IE1B
Q0hJTkUodm1zKTsKKyAgICBpbnQzMl90IGwydmljX3BoYW5kbGUgPSBxZW11X2ZkdF9hbGxvY19w
aGFuZGxlKG1zLT5mZHQpOworICAgIGNoYXIgKm5vZGVuYW1lID0gZ19zdHJkdXBfcHJpbnRmKCIv
c29jL2ludGVycnVwdC1jb250cm9sbGVyQCV4IiwKKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBtX2NmZy0+bDJ2aWNfYmFzZSk7CisgICAgY29uc3QgY2hhciBjb21wYXRbXSA9
ICJxY29tLGgyLXBpY1wwaHZtLXBpYyI7CisKKyAgICBxZW11X2ZkdF9zZXRwcm9wX2NlbGwobXMt
PmZkdCwgIi9zb2MiLCAiaW50ZXJydXB0LXBhcmVudCIsIGwydmljX3BoYW5kbGUpOworCisgICAg
cWVtdV9mZHRfYWRkX3N1Ym5vZGUobXMtPmZkdCwgbm9kZW5hbWUpOworICAgIHFlbXVfZmR0X3Nl
dHByb3BfY2VsbChtcy0+ZmR0LCBub2RlbmFtZSwgIiNhZGRyZXNzLWNlbGxzIiwgMHgwKTsKKyAg
ICBxZW11X2ZkdF9zZXRwcm9wX2NlbGwobXMtPmZkdCwgbm9kZW5hbWUsICIjaW50ZXJydXB0LWNl
bGxzIiwgMHgxKTsKKyAgICBxZW11X2ZkdF9zZXRwcm9wKG1zLT5mZHQsIG5vZGVuYW1lLCAiY29t
cGF0aWJsZSIsIGNvbXBhdCwgc2l6ZW9mKGNvbXBhdCkpOworICAgIHFlbXVfZmR0X3NldHByb3Bf
Y2VsbHMobXMtPmZkdCwgbm9kZW5hbWUsICJyZWciLCAwLAorICAgICAgICAgICAgICAgICAgICAg
ICAgICAgbV9jZmctPmwydmljX2Jhc2UsIG1fY2ZnLT5sMnZpY19zaXplKTsKKyAgICBxZW11X2Zk
dF9zZXRwcm9wKG1zLT5mZHQsIG5vZGVuYW1lLCAiaW50ZXJydXB0LWNvbnRyb2xsZXIiLCBOVUxM
LCAwKTsKKyAgICBxZW11X2ZkdF9zZXRwcm9wX2NlbGwobXMtPmZkdCwgbm9kZW5hbWUsICJwaGFu
ZGxlIiwgbDJ2aWNfcGhhbmRsZSk7CisKKyAgICBnX2ZyZWUobm9kZW5hbWUpOworICAgIHJldHVy
biBsMnZpY19waGFuZGxlOworfQorCiBzdGF0aWMgdm9pZCBmZHRfYWRkX2h2eChIZXhhZ29uVmly
dE1hY2hpbmVTdGF0ZSAqdm1zLAogICAgICAgICAgICAgICAgICAgICAgICAgY29uc3Qgc3RydWN0
IGhleGFnb25fbWFjaGluZV9jb25maWcgKm1fY2ZnKQogewpAQCAtMTc1LDEzICsxOTksMTYgQEAg
c3RhdGljIHZvaWQgZmR0X2FkZF9jcHVfbm9kZXMoY29uc3QgSGV4YWdvblZpcnRNYWNoaW5lU3Rh
dGUgKnZtcykKICAgICB9CiB9CiAKLXN0YXRpYyB2b2lkIGNyZWF0ZV92aXJ0aW9fZGV2aWNlcyhI
ZXhhZ29uVmlydE1hY2hpbmVTdGF0ZSAqdm1zKQorc3RhdGljIHZvaWQgY3JlYXRlX3ZpcnRpb19k
ZXZpY2VzKEhleGFnb25WaXJ0TWFjaGluZVN0YXRlICp2bXMsCisgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgaW50MzJfdCBsMnZpY19waGFuZGxlKQogeworICAgIE1hY2hpbmVTdGF0
ZSAqbXMgPSBNQUNISU5FKHZtcyk7CiAgICAgaHdhZGRyIHNpemUgPSBiYXNlX21lbW1hcFtWSVJU
X01NSU9dLnNpemU7CiAKICAgICBmb3IgKGludCBpID0gMDsgaSA8IFZJUlRJT19ERVZfQ09VTlQ7
IGkrKykgewogICAgICAgICBpbnQgaXJxID0gVklSVElPX0lSUV9CQVNFICsgaTsKICAgICAgICAg
aHdhZGRyIGJhc2UgPSBiYXNlX21lbW1hcFtWSVJUX01NSU9dLmJhc2UgKyBpICogc2l6ZTsKKyAg
ICAgICAgY2hhciAqbm9kZW5hbWUgPSBnX3N0cmR1cF9wcmludGYoIi9zb2MvdmlydGlvX21taW9A
JSIgUFJJeDY0LCBiYXNlKTsKICAgICAgICAgRGV2aWNlU3RhdGUgKmRldiA9IHFkZXZfbmV3KCJ2
aXJ0aW8tbW1pbyIpOwogICAgICAgICBTeXNCdXNEZXZpY2UgKnMgPSBTWVNfQlVTX0RFVklDRShk
ZXYpOwogCkBAIC0xOTIsNiArMjE5LDE2IEBAIHN0YXRpYyB2b2lkIGNyZWF0ZV92aXJ0aW9fZGV2
aWNlcyhIZXhhZ29uVmlydE1hY2hpbmVTdGF0ZSAqdm1zKQogICAgICAgICBzeXNidXNfY29ubmVj
dF9pcnEocywgMCwKICAgICAgICAgICAgICAgICAgICAgICAgICAgIHFkZXZfZ2V0X2dwaW9faW4o
dm1zLT5wYXJlbnRfb2JqLmwydmljLCBpcnEpKTsKICAgICAgICAgdm1zLT52aXJ0aW9fbW1pb1tp
XSA9IGRldjsKKworICAgICAgICBxZW11X2ZkdF9hZGRfc3Vibm9kZShtcy0+ZmR0LCBub2RlbmFt
ZSk7CisgICAgICAgIHFlbXVfZmR0X3NldHByb3Bfc3RyaW5nKG1zLT5mZHQsIG5vZGVuYW1lLCAi
Y29tcGF0aWJsZSIsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJ2aXJ0aW8sbW1p
byIpOworICAgICAgICBxZW11X2ZkdF9zZXRwcm9wX2NlbGxzKG1zLT5mZHQsIG5vZGVuYW1lLCAi
cmVnIiwgMCwgYmFzZSwgc2l6ZSk7CisgICAgICAgIHFlbXVfZmR0X3NldHByb3BfY2VsbChtcy0+
ZmR0LCBub2RlbmFtZSwgImludGVycnVwdHMiLCBpcnEpOworICAgICAgICBxZW11X2ZkdF9zZXRw
cm9wX2NlbGwobXMtPmZkdCwgbm9kZW5hbWUsICJpbnRlcnJ1cHQtcGFyZW50IiwKKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGwydmljX3BoYW5kbGUpOworCisgICAgICAgIGdfZnJlZShu
b2RlbmFtZSk7CiAgICAgfQogfQogCkBAIC0yNTEsNiArMjg4LDcgQEAgc3RhdGljIHZvaWQgdmly
dF9pbml0KE1hY2hpbmVTdGF0ZSAqbXMpCiAgICAgSGV4YWdvblZpcnRNYWNoaW5lU3RhdGUgKnZt
cyA9IEhFWEFHT05fVklSVF9NQUNISU5FKG1zKTsKICAgICBjb25zdCBzdHJ1Y3QgaGV4YWdvbl9t
YWNoaW5lX2NvbmZpZyAqbV9jZmcgPSAmdjY4bl8xMDI0OwogICAgIGludDMyX3QgY2xrX3BoYW5k
bGU7CisgICAgaW50MzJfdCBsMnZpY19waGFuZGxlOwogCiAgICAgY3JlYXRlX2ZkdCh2bXMpOwog
ICAgIHFlbXVfZmR0X3NldHByb3Bfc3RyaW5nKG1zLT5mZHQsICIvY2hvc2VuIiwgImJvb3Rhcmdz
IiwgbXMtPmtlcm5lbF9jbWRsaW5lKTsKQEAgLTI3Miw3ICszMTAsOCBAQCBzdGF0aWMgdm9pZCB2
aXJ0X2luaXQoTWFjaGluZVN0YXRlICptcykKIAogICAgIGZkdF9hZGRfaHZ4KHZtcywgbV9jZmcp
OwogCi0gICAgY3JlYXRlX3ZpcnRpb19kZXZpY2VzKHZtcyk7CisgICAgbDJ2aWNfcGhhbmRsZSA9
IGZkdF9hZGRfbDJ2aWModm1zLCBtX2NmZyk7CisgICAgY3JlYXRlX3ZpcnRpb19kZXZpY2VzKHZt
cywgbDJ2aWNfcGhhbmRsZSk7CiAKICAgICBnX2F1dG9mcmVlIEhleGFnb25DUFUgKipjcHVzID0g
Z19uZXcoSGV4YWdvbkNQVSAqLCBtcy0+c21wLmNwdXMpOwogCi0tIAoyLjM0LjEKCg==

