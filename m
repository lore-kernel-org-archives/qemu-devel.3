Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1076C606A335
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 18:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=C5lKDN1Z;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bqkHhTdQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUTEQ-0006H7-H0; Fri, 20 Nov 2026 13:21:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xUTEF-00062f-Bg
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 13:20:55 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xUTED-0000q6-M4
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 13:20:55 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKEfZo5048964
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 18:20:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rP5KFfKFgBy93H239WRP7Escww7/PQa0uMZOFKHOh08=; b=C5lKDN1Z5u2UfN2+
 pln/wTpbgWy9ChWTndCM8+ODYKwh5xOPmVSeuT8kk/37kbOwujn7R3YNPpv2rTYR
 7I2OaxfUX+6jDi5bVHW6M34TKHpgbfb2Y4Y76nDXcFglDwGeLbc2n4hL96KXo2MT
 eldwqGr0SOUWkRmzYEbG6k1YiYwwnwiSjhXk7G6vQsKtYs51ZZHmapl8d17uowCl
 3GJnFQ0lzmhgqI/4Hy7Nr27hUNrKRFfNolTc0mg8A9LjvmCLccLeZxZFwkrZ+4xA
 fYJmkYXugBL+jgrV3oQYauBpNhkDY1t2l+KPp21XZAV1mWAdp6U5xtZ+0pXrFBlb
 W9ob7w==
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2mm4hwmg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 18:20:52 +0000 (GMT)
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-71ad455a8c1so721875eaf.2
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 10:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795198852; x=1795803652; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rP5KFfKFgBy93H239WRP7Escww7/PQa0uMZOFKHOh08=;
 b=bqkHhTdQHhgJ5A7nq9QDYI1rR69/9zSaMg+R5YqCTp11VRZeXuy0j8mp/3q7JnDjLn
 U+Ey4+pMoEgdceKmCqf/osBjvQq20Ow3No6IQXLUAOsnE/GSi0Xk5YdSW+5HiaHD2BWp
 oSTHq0diCdOd+ZQL6ZQt1elpBTb1IZ8Yn9NSHNY77sALh0a8g3GM0oDnqieHs//gBSS2
 M04QMpyx02y9pv5Ydpzt5w73gk7cEYhABZd8qkuTa+DgFHwBk4GkVzOp1yu3EGVzPcVK
 z7zJaFlKSCb1AJ5A1IsnLWJ3pLtZu5ycb1sZFf7LoOdB9nv86E2NZQ6HFOgtxXmvhm+P
 T7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795198852; x=1795803652;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rP5KFfKFgBy93H239WRP7Escww7/PQa0uMZOFKHOh08=;
 b=S8n/5cHPZWj5j7vWnPAt+DiTXAEPKRgG2qaFoyg5Y+UrtzmFJ0+oyQVrNrY8FUEsQP
 M1UUDxu2bvl5a0CmA+awWK9opXUlD9yh05vkzTqVz/k81VwFHCA5XOMiCHLRTVya+bgN
 NErBD6x0bwjV4oEmCTQO61T+eMA5Vz/96TLty5CpINFYAFrwK1wYtpWg7Muq0txUyJgA
 hUtUTVZw/0t1T5QtL7CuLSslnPCpy8L+TLtABkn6iVNAryZi4PpJMuN3BbPfYHB0UyXu
 MiMltXUUh9XtO1EBbdZ6Hn4Zn1owELOs6/fdfB9NFGTwcGByteJFKGbXDlYWKXacVQje
 N2Qg==
X-Gm-Message-State: APuU4Z9QdOZ7fuwAuPz9e1ybp2T+1eU+7tgUXZgS1EVTBJoA2jkVonJD
 QMIAw8ZxNmS44Gv/W7a81rqwAFy2Z4wWxo23bwOCrY3FRizl4WyODVHKUAOFvcJypSMZBBmirhh
 LtZmCY32ckV+7p6l2kcvRQCtvgC6ylFQKqz4I6m8DRseT6GS+8oq9pqVUAosumA07wA==
X-Gm-Gg: AYBFou3wef/kgslqZY+2vmf8rX6uQH443uf3i7UR5rwyqhW1rdC1v9o7JxZy78+sg1J
 nPXw1xMET9A4/f+h9l3GQEoOKYVwohehqyWx4JdE2oC6wGHBpddnmgIwpeR/+cbhKJMhTlLqXJz
 qoVx+/0LSo+/qbuexk56uROxlCh5707x2BV7yOxU14pC6IAfjnVddW50xfK19FQt4XZ6agDDGWZ
 sy1cryV5vtj978Idy7AUZ22J5PnevqT0M9MXRMYBsc1qcYjp4S+fJaHwJIS4nqGZ28nSxKNmDmi
 NuJRmPqkpJNS5Lrjq9kcI5iQTv0HTBjep/pQ9Hx8m9XtmPo/07GLw4Jq1zQpBd9I7nrt4b2dmzd
 cdWIvqbHoc5g5ATX3y7Lz6DF+0GpdXNQii9T+04xHp0qDbvyAJQyxGAV7E72cuBFwR51Br3uc1B
 AiraeahWgiCJQqxMIlhYGABA==
X-Received: by 2002:a05:6820:f016:b0:70e:1dd8:6713 with SMTP id
 006d021491bc7-71b39568e7cmr3098531eaf.71.1795198851976; 
 Fri, 20 Nov 2026 10:20:51 -0800 (PST)
X-Received: by 2002:a05:6820:f016:b0:70e:1dd8:6713 with SMTP id
 006d021491bc7-71b39568e7cmr3098510eaf.71.1795198851569; 
 Fri, 20 Nov 2026 10:20:51 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8631690fd36sm2698364a34.20.2026.11.20.10.20.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 10:20:50 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Brian Cain <brian.cain@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH-for-11.2 v2 12/12] hw/hexagon: version the virt machine type
Date: Fri, 20 Nov 2026 10:20:31 -0800
Message-Id: <20261120182031.560481-13-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261120182031.560481-1-brian.cain@oss.qualcomm.com>
References: <20261120182031.560481-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: AZ8Ff4LkHjgti1yU5X6MWQtufHY3nii2
X-Authority-Analysis: v=2.4 cv=RZYFmFtv c=1 sm=1 tr=0 ts=6b008f84 cx=c_pps
 a=lVi5GcDxkcJcfCmEjVJoaw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=RWXkQjlZBxIzdYGjihoA:9 a=QEXdDO2ut3YA:10
 a=rBiNkAWo9uy_4UTK5NWh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3MiBTYWx0ZWRfX7nOi2KohVIL4
 n+BETJfqACrISMXuMpNn658H56OgJ+1I57oo/fZPxMfgOXcfL5c1ae33cqIr1Rsmqrg6BgjO3MV
 db3UrHSXNecjzVTvwspCisDObs552lg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3MiBTYWx0ZWRfX7HGBf2y4ysv8
 +zBhoEdlvIRFV4Xhmp8mgO3KIVO+Z8qL9xi4ZbL7iqpqBAP6YNHD2DMKdBq7sU3S8Z46pYnLq/K
 qMaB7qlGSwtobmx5IV7ks2v81asWbtEqhSbxaSGhd2HzK16xR1zpBEIaNffkO/C/aWIoqT1yH/P
 iD0azHfluTtsmrDGBSlUqttKQ3DNUPsvOPRoEpGgfUuerKizthv5wVRnOzdVd/NmKD5JQOiQzUE
 O6uCF7MEZwNy5JUxO57HDj7s3G/NLTypaTXH+E69cmvLe/4CpOvuioNUcevqPfveT1g8Y5IyyG3
 nOHNZtiZt6a0z4//RTnuwuzbBwkQqjaGjBcxkySLf4Vd8ZwVtgD2EscwoEufR2h7R2x4Avq9qLk
 KTEOQxo4foTfId5l2dPhJref77H7P49imkT5/v81SUreEKPUQYPMVulaPrcMHt3CTMnP8cfURuu
 xtQ9maDExitMwSzwEnA==
X-Proofpoint-GUID: AZ8Ff4LkHjgti1yU5X6MWQtufHY3nii2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200072
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

TWFrZSB0aGUgZXhpc3RpbmcgdmlydCB0eXBlIGFic3RyYWN0IGFuZCBhZGQgdmlydC0xMS4yIGFz
IGl0cyBvbmx5CmNvbmNyZXRlIHR5cGUsIGFsaWFzZWQgYXMgInZpcnQiLgoKU2lnbmVkLW9mZi1i
eTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIGRvY3Mvc3lz
dGVtL2hleGFnb24vbWFjaGluZXMucnN0IHwgIDMgKysrCiBody9oZXhhZ29uL3ZpcnQuYyAgICAg
ICAgICAgICAgICB8IDM3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiAyIGZpbGVz
IGNoYW5nZWQsIDQwIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kb2NzL3N5c3RlbS9oZXhh
Z29uL21hY2hpbmVzLnJzdCBiL2RvY3Mvc3lzdGVtL2hleGFnb24vbWFjaGluZXMucnN0CmluZGV4
IGE0NzYwYjdhNWIxLi4zYmRmNWVhYzI2ZSAxMDA2NDQKLS0tIGEvZG9jcy9zeXN0ZW0vaGV4YWdv
bi9tYWNoaW5lcy5yc3QKKysrIGIvZG9jcy9zeXN0ZW0vaGV4YWdvbi9tYWNoaW5lcy5yc3QKQEAg
LTI5LDYgKzI5LDkgQEAgaGFyZHdhcmUgYXZhaWxhYmxlIHRvIHRoZSBndWVzdCwgaW5jbHVkaW5n
IENQVXMsIGludGVycnVwdCBjb250cm9sbGVyLAogY29uc29sZSwgdmlydGlvIGRldmljZXMsIGFu
ZCBhY2NlbGVyYXRvciBjYXBhYmlsaXRpZXMuIFNlZSA6ZG9jOmBib290YCBmb3IKIGl0cyBib290
IHByb3RvY29sLgogCitgYHZpcnRgYCBpcyBhbiBhbGlhcyBmb3IgdGhlIGxhdGVzdCB2ZXJzaW9u
ZWQgbWFjaGluZSB0eXBlLCBjdXJyZW50bHkKK2BgdmlydC0xMS4yYGAuCisKIEJvYXJkLXNwZWNp
ZmljIENEU1AgYW5kIE5TUCBtYWNoaW5lcwogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tCiAKZGlmZiAtLWdpdCBhL2h3L2hleGFnb24vdmlydC5jIGIvaHcvaGV4YWdvbi92aXJ0
LmMKaW5kZXggMzMyN2UyOGQxMjEuLjdjNzk4MjIyYmE2IDEwMDY0NAotLS0gYS9ody9oZXhhZ29u
L3ZpcnQuYworKysgYi9ody9oZXhhZ29uL3ZpcnQuYwpAQCAtMTYxLDcgKzE2MSw0NCBAQCBzdGF0
aWMgY29uc3QgVHlwZUluZm8gdmlydF9tYWNoaW5lX3R5cGVzW10gPSB7IHsKICAgICAucGFyZW50
ID0gVFlQRV9IRVhBR09OX0NPTU1PTl9NQUNISU5FLAogICAgIC5pbnN0YW5jZV9zaXplID0gc2l6
ZW9mKEhleGFnb25WaXJ0TWFjaGluZVN0YXRlKSwKICAgICAuY2xhc3NfaW5pdCA9IHZpcnRfY2xh
c3NfaW5pdCwKKyAgICAuYWJzdHJhY3QgPSB0cnVlLAogICAgIC5pc19hdmFpbGFibGUgPSB0YXJn
ZXRfaGV4YWdvbiwKIH0gfTsKIAogREVGSU5FX1RZUEVTKHZpcnRfbWFjaGluZV90eXBlcykKKwor
I2RlZmluZSBERUZJTkVfVklSVF9NQUNISU5FX0lNUEwobGF0ZXN0LCAuLi4pIFwKKyAgICBzdGF0
aWMgdm9pZCBNQUNISU5FX1ZFUl9TWU0oY2xhc3NfaW5pdCwgdmlydCwgX19WQV9BUkdTX18pKCBc
CisgICAgICAgIE9iamVjdENsYXNzICpvYywgXAorICAgICAgICBjb25zdCB2b2lkICpkYXRhKSBc
CisgICAgeyBcCisgICAgICAgIE1hY2hpbmVDbGFzcyAqbWMgPSBNQUNISU5FX0NMQVNTKG9jKTsg
XAorICAgICAgICBNQUNISU5FX1ZFUl9TWU0ob3B0aW9ucywgdmlydCwgX19WQV9BUkdTX18pKG1j
KTsgXAorICAgICAgICBtYy0+ZGVzYyA9ICJRRU1VICIgTUFDSElORV9WRVJfU1RSKF9fVkFfQVJH
U19fKSBcCisgICAgICAgICAgICAgICAgICAgIiBIZXhhZ29uIFZpcnR1YWwgTWFjaGluZSI7IFwK
KyAgICAgICAgTUFDSElORV9WRVJfREVQUkVDQVRJT04oX19WQV9BUkdTX18pOyBcCisgICAgICAg
IGlmIChsYXRlc3QpIHsgXAorICAgICAgICAgICAgbWMtPmFsaWFzID0gInZpcnQiOyBcCisgICAg
ICAgIH0gXAorICAgIH0gXAorICAgIHN0YXRpYyBjb25zdCBUeXBlSW5mbyBNQUNISU5FX1ZFUl9T
WU0oaW5mbywgdmlydCwgX19WQV9BUkdTX18pID0gXAorICAgIHsgXAorICAgICAgICAubmFtZSA9
IE1BQ0hJTkVfVkVSX1RZUEVfTkFNRSgidmlydCIsIF9fVkFfQVJHU19fKSwgXAorICAgICAgICAu
cGFyZW50ID0gVFlQRV9IRVhBR09OX1ZJUlRfTUFDSElORSwgXAorICAgICAgICAuY2xhc3NfaW5p
dCA9IE1BQ0hJTkVfVkVSX1NZTShjbGFzc19pbml0LCB2aXJ0LCBfX1ZBX0FSR1NfXyksIFwKKyAg
ICAgICAgLmlzX2F2YWlsYWJsZSA9IHRhcmdldF9oZXhhZ29uLCBcCisgICAgfTsgXAorICAgIHN0
YXRpYyB2b2lkIE1BQ0hJTkVfVkVSX1NZTShyZWdpc3RlciwgdmlydCwgX19WQV9BUkdTX18pKHZv
aWQpIFwKKyAgICB7IFwKKyAgICAgICAgTUFDSElORV9WRVJfREVMRVRJT04oX19WQV9BUkdTX18p
OyBcCisgICAgICAgIHR5cGVfcmVnaXN0ZXJfc3RhdGljKCZNQUNISU5FX1ZFUl9TWU0oaW5mbywg
dmlydCwgX19WQV9BUkdTX18pKTsgXAorICAgIH0gXAorICAgIHR5cGVfaW5pdChNQUNISU5FX1ZF
Ul9TWU0ocmVnaXN0ZXIsIHZpcnQsIF9fVkFfQVJHU19fKSk7CisKKyNkZWZpbmUgREVGSU5FX1ZJ
UlRfTUFDSElORV9BU19MQVRFU1QobWFqb3IsIG1pbm9yKSBcCisgICAgREVGSU5FX1ZJUlRfTUFD
SElORV9JTVBMKHRydWUsIG1ham9yLCBtaW5vcikKKworc3RhdGljIHZvaWQgdmlydF9tYWNoaW5l
XzExXzJfb3B0aW9ucyhNYWNoaW5lQ2xhc3MgKm1jKQoreworfQorREVGSU5FX1ZJUlRfTUFDSElO
RV9BU19MQVRFU1QoMTEsIDIpCi0tIAoyLjM0LjEKCg==

