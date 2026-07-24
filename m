Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 863C5C531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 18:38:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnKm7-0002ME-Vf; Fri, 24 Jul 2026 14:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wnKlV-0002CR-W5
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 14:37:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wnKlS-0000sK-DI
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 14:36:57 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66OGqQbS594613
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 18:36:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :message-id:mime-version:subject:to; s=qcppdkim1; bh=Epfk/Sp7lGu
 LoHxoxbIyzW+gH4Q0Y9DkZrBwTj1OoKY=; b=dhwkrrMUYuOcJGYt7cQls8BQHpP
 OmT4ojH1Z6BdUYQurcveLnqM2r7oHGgeRu41sM2vKLtJemV0Db6LqT58xAitv7Dl
 Lzahb3CFG4Eulr8QB9j91x6kQ1bU+wuU8S5OqbR183rbSlGAhZcjTjVJxyBWvBBb
 G1OsMwDXg4MD2Mn0OMbFv2049IY5kb7cVmTioY9p5h66DB9+hDIPHcdHtcrgISj1
 CcJPdHzFp66I6QyTJkQNcBuV0kTPi7NL6gbRRxvM2oZ8ymyQb4Vv7lNcYlu/X74O
 OHEBtw3PmWTCnDwgZ6CE1wsEh+bhCtpgZdmXe5Ou/571cKbkvGFZh1UEaZA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm8ck97kx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 18:36:51 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cb5cc1e13f8so820509a12.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 11:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784918211; x=1785523011; darn=nongnu.org;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Epfk/Sp7lGuLoHxoxbIyzW+gH4Q0Y9DkZrBwTj1OoKY=;
 b=cHrFXmmMe6wFIUgbZA0r9WcfclTbd1nzXhDlLoAJwf0aTVmhCZIMDkgvbk0DqwhxVc
 R2ERmdj4NF87UGftGWYQt2D0WOIgcRDBE7+jhUf9IfJ9TG/JAQfh+8ruKOsXUuq/QSB0
 vizGa62FgAi3BFq9s+PV2fmQT6PxLxGCvvK8zgY9acaoOfG/QdJcEO92pGSt6gYqZdyz
 fYjCNgLqbHmOyl4dR2MhS1iN6bDS7t9Qzmannaxx+A8idjP3iXx5nrSrYeur61/fA1Bd
 qWABN5gH93hkxRloamhHok3pjRQsF59RNKuhfU/J7++TAFwnJR8MZC4DNcw3XJfWMigs
 Rt+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784918211; x=1785523011;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Epfk/Sp7lGuLoHxoxbIyzW+gH4Q0Y9DkZrBwTj1OoKY=;
 b=dftOyNORyAMUkzNLDemZALEeVgZr5jL2NPkAkiyg9zvc8jtTYaZj6mHXeHkiFAgoFS
 S5+Px7prZREBs5PHlhXkew5Tequf2+Ei68T+gwXu4uikah4mdpwNg9e2WtpdI7crwxga
 Q49AkFO78xGgz6y8Gtp+CTZYB9iFfYRh43Y2qb9NXcuDKXNsnqPHwd55fzsp/OXBPIhq
 TFUrW8hpV1XtQMHGbWAYzMRnWuuG6kwIFgDBd09uRfDtHwG/x32bkijyaSYSUhc4r1Ur
 S2viEkSnRmdnXikIyvrc35K1ZzJ8stIqIK3O0ozfYzu1/gNkvYMGp1q8VgkpzP844+bE
 9xvA==
X-Gm-Message-State: AOJu0YyLInn/Ay6MIaIpN6mMQCKlKt0uBoZvK/TjzjhSgXT5fqU9tnh9
 LAIH/PBlslMzlyfDBbEHdabkf+yrNvLXzIuF9XS/3sG4YACOve3aCC1gyBJ4tBWjcrPFByFAP2X
 wXy60J9saxa+Y+xi/si6c0f7SK4tHUAHNHNw15ZobTDLNhYjtuPdTRAEI+P3QQ1+vUg==
X-Gm-Gg: AR+sD126AIYpCBEcDf8LZ+vvNT5ou1iiUYPCOJUF34znVFMTNN8Fkg8iFCRkGHiXyLJ
 1Hmcf/Fhcr2UgUf1iywiW74ihNV50OKsHe6DNQg8GFR8/9agkbkLeMtgnlSjDtHqaQbCxfU4kjE
 WcSZsNO9NG+zRtfkg0T6blsH5z2iPpSTK869o/V3lzKzqXFyXExYBCIsYuUPvkrY4HhJ79Usjca
 XA8Uln3XrI+Y0kakrcc258NHF6vEeh5FdZlYyuxTwvO6qU8a9BVF/8NR8nOcOYRHjQUVgMb/A3m
 i/vmHW9tuE7M12riYjoZYXUMArv6BsQuRi7AR8Sc9WItokqBviVUCaku5fF/CjzeMB89Lrl2K4s
 2vKBdp3H9IrXduwZf6W5oSt4pPjolKWSICDfJWY9W1+TgA8O6
X-Received: by 2002:a05:6a21:6e03:b0:3c3:96dd:9ecc with SMTP id
 adf61e73a8af0-3c44b201100mr8928480637.57.1784918210657; 
 Fri, 24 Jul 2026 11:36:50 -0700 (PDT)
X-Received: by 2002:a05:6a21:6e03:b0:3c3:96dd:9ecc with SMTP id
 adf61e73a8af0-3c44b201100mr8928467637.57.1784918210216; 
 Fri, 24 Jul 2026 11:36:50 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13e0f4a039asm49194c88.9.2026.07.24.11.36.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 11:36:49 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, matheus.bernardino@oss.qualcomm.com, 
 philmd@oss.qualcomm.com, Brian Cain <brian.cain@oss.qualcomm.com>,
 pierrick.bouvier@oss.qualcomm.com, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 00/14] Add hexagon l2vic, qtimer devices
Date: Fri, 24 Jul 2026 11:36:34 -0700
Message-Id: <20260724183648.190531-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDE2NyBTYWx0ZWRfX/+c3gsrvuwb4
 X25ohGNTqxqiwh9+a6noeLtErn/8aZ6W7ZODKROAZDdupeGLKO/o0egeFpsML4rYXifS2GwlA4M
 O4b8YOVq3cG/ljvwOlPE4z08nX9cCDfQmlAZiHp5STstn2PJXVdCtEKiCE8X1q6RWpWaXds6liS
 wS8pjZJYjhH7E0S6m7JLKlF+dpNPIzNfiUKC+t8DGt/Wljnf890ciPEuHU7wtqmtC0jx33/6Plu
 Uh4SGOPy5uA5sGMsWjfgD3Zryul0KF1d08gDxJ7R3ki5VEBG89Ptx8T6C8ept8roTUkkOyODPi0
 eZBU1X+GclsbXlFRC5Sxu63rKNQNbI9BedCAG0dYRfoQHcKl+n9JBH5RuSbo5ic5pQ9sHCFmqkv
 Z29djz869S96TtvZbcVvTetMtAgCb+iDhV87ZehZUv+OOOEKQ13QPjyMr1GpAanaYZ03/9mV6Dr
 3EWfTxzR98PQnUDLQeg==
X-Proofpoint-GUID: CzRIYy0qgiRyknKLTLbUSTuQtIVsBhc6
X-Proofpoint-ORIG-GUID: CzRIYy0qgiRyknKLTLbUSTuQtIVsBhc6
X-Authority-Analysis: v=2.4 cv=F79nsKhN c=1 sm=1 tr=0 ts=6a63b0c3 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=MzPDdJr6ZuC22SrPOUIA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDE2NyBTYWx0ZWRfXxUAEcXd/Kuyz
 mQTrJnhXkjp2mhawifV5SPbCaZfOe+SAbGWn28AQpzWOK0VHxQaxpUSJUV9F6kYkjf7s0qWnPK1
 e0ZSoDbiol3hL7OQcHHZVITNSk+fu8A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240167
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

VGhlIHByZXZpb3VzbHkgaW5kZXBlbmRlbnQgdGhyZWFkcyBmb3IgbDJ2aWMgYW5kIHF0aW1lciBh
cmUgbm93IGNvbWJpbmVkLAp3aGljaCBzZWVtcyB0byBtYWtlIHRoZSBtb3N0IHNlbnNlIGJlY2F1
c2UgcXRpbWVyIHRlc3RpbmcgZWZmZWN0aXZlbHkKZGVwZW5kcyBvbiBsMnZpYy4KCm5ldzoKKiAi
cmVmYWN0b3Igd2l0aCBoZXgtc3Vic3lzIjogdmlydC9EU1AgbWFjaGluZXMgYnVpbGQgdGhlIHNh
bWUgY29yZSBzdWJzeXMsCnNvIGV4dHJhY3QgaXQgaW50byBody9oZXhhZ29uL2hleC1zdWJzeXMu
Yy4gIENQVXMgYXJlIG5vdyB1bmRlciBhIFRZUEVfQ1BVX0NMVVNURVIuCiogImV4dHJhY3QgZ2V0
X3JlZ192YWx1ZS9zZXRfcmVnX3ZhbHVlIHN0dWJzIjogcm91dGVzIGdsb2JhbHJlZwpyL3cgdGhy
b3VnaCBhY2Nlc3NvcnMuCiogdmlydCBtYWNoaW5lIGdhaW5zIHZpcnRpby1tbWlvIHRyYW5zcG9y
dHMKKiBhZGRsIGhleGFnb24tYXJjaC10ZXN0cyBlbmFibGVkCgpsMnZpYyBjaGFuZ2VzOgoqIFJl
bW92ZWQgdGhlIFFlbXVNdXRleCAiYWN0aXZlIjsgdGhlIGRldmljZSBydW5zIHVuZGVyIHRoZSBC
UUwuCiogRHJvcHBlZCB0aGUgUUVNVV9BTElHTkVEKDE2KSBhdHRyaWJ1dGUgZnJvbSB0aGUgYml0
bWFwczsgbm8KbG9uZ2VyIG5lZWRlZCBub3cgdGhhdCBhY2Nlc3MgZ29lcyB0aHJvdWdoIHRoZSBi
aXRtYXAzMiBoZWxwZXJzLgoqIENvbGxhcHNlZCBpbnRfZ3JvdXBfbjAuLmludF9ncm91cF9uMyBp
bnRvIGFuIGludF9ncm91cF9uWzRdIGFycmF5LgoqIE1vdmVkIHRoZSByZWctb2Zmc2V0IG1hY3Jv
cyBhbmQgTDJWSUNfSU5URVJSVVBUX01BWCBmcm9tIGhkciB0byBzcmMKKiBTd2l0Y2hlZCB0byBE
RUZJTkVfVFlQRVMoKQoqIFJlbmFtZWQgdGhlIHZpZDAgZmllbGQgdG8gdmlkCgpnbG9iYWxyZWcg
Y2hhbmdlczoKKiBWSUQvVklEMSBhbmQgVElNRVJMTy9USU1FUkhJIG5vdyBnbyB0aHJvdWdoIGdl
dF9yZWdfdmFsdWUvCnNldF9yZWdfdmFsdWUsIGRpcmVjdGluZyB0byBMMlZJQyBhbmQgUVRpbWVy
IHJlc3BlY3RpdmVseS4KKiBsMnZpYyBhbmQgcXRpbWVyIGxpbmtzIGFyZSBjaGVja2VkIGF0IHJl
YWxpemF0aW9uCgp3aXJpbmcgY2hhbmdlczoKKiBSZW5hbWVkIGwydmljX2RldiB0byBsMnZpYwoq
IFJld29yZGVkIHRoZSBjb25uZWN0LWwydmljIGNvbW1pdCBtZXNzYWdlCgpxdGltZXIgY2hhbmdl
czoKKiBSZW5hbWVkIHRoZSAiZnJlcSIgcHJvcGVydHkgdG8gImZyZXEtaHoiIGFuZCB0aGUgZmll
bGQgdG8gZnJlcV9oegoqIFBlci1mcmFtZSBmcmVxdWVuY3kgbm93IGluaGVyaXRzIHRoZSBkZXZp
Y2UgZnJlcV9oeiBwcm9wZXJ0eSwKc28gaXQgaXMgb3ZlcnJpZGFibGUuCiogQWRkZWQgLmltcGwg
PSB7NCwgNH0gdG8gcWN0X3F0aW1lcl9hY19vcHMuCiogQWRkZWQgcWN0X3F0aW1lcl91bnJlYWxp
emUoKS4KKiBkZW11eCB1c2VzIChRQ1RfUVRJTUVSX1RJTUVSX0ZSQU1FX0VMVFMgLSAxKSAqIHN0
cmlkZSBpbnN0ZWFkIG9mIGEKaGFyZGNvZGVkIDB4ZiAqIHN0cmlkZS4KKiBnZXR0ZXJzIHRha2Ug
YSBjb25zdCBRY3RRdGltZXJJbnRlcmZhY2UgKi4KKiBTd2l0Y2hlZCB0byBERUZJTkVfVFlQRVMo
KS4KKiBSZW1vdmVkIHBlci1mcmFtZSBmcmVxX2h6LCB0aGVzZSBhbGwgcmVhZC10aHJvdWdoIHRv
IHRoZSB0aW1lcidzIGZyZXEuCgp0ZXN0IGNoYW5nZXM6CiogcWN0LXF0aW1lciBxdGVzdDogdGhl
IHZpZXctcmVnaW9uIGJhc2UgaXMgbm93IHRha2VuIHBlci1tYWNoaW5lIGZyb20KdGhlIG1hY2hp
bmUgY29uZmlnIHJhdGhlciB0aGFuIGEgaGFyZGNvZGVkIGFkZHIsIGFuZAp0aGUgcmVkdW5kYW50
IGd1YXJkIGFyb3VuZCB0aGUgYXNzZXJ0IGlzIHJlbW92ZWQuCgpsMnZpYyB2MjogaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI2MDcxNTE4NTcwMS4xMjg3MTc2LTEtYnJpYW4u
Y2FpbkBvc3MucXVhbGNvbW0uY29tLwpsMnZpYyB2MTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
cWVtdS1kZXZlbC8yMDI2MDcxNDE1NTEyNi4zNTA5NTQ0LTEtYnJpYW4uY2FpbkBvc3MucXVhbGNv
bW0uY29tLwpxdGltZXIgdjE6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAy
NjA3MTgwMTMyNDEuMTU1MDEyNC0xLWJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbS8KCkJyaWFu
IENhaW4gKDEzKToKICBody9oZXhhZ29uOiByZWZhY3RvciB3aXRoIGhleC1zdWJzeXMKICBiaXRv
cHMuaDogQWRkIGZpbmRfZmlyc3RfYml0MzIoKQogIGh3L2hleGFnb246IGV4dHJhY3QgZ2V0X3Jl
Z192YWx1ZS9zZXRfcmVnX3ZhbHVlIHN0dWJzIGluIGdsb2JhbHJlZwogIGh3L2hleGFnb246IGNv
bm5lY3QgbDJ2aWMgZGV2aWNlCiAgaHcvaGV4YWdvbi92aXJ0OiBpbnN0YW50aWF0ZSB2aXJ0aW8t
bW1pbyB0cmFuc3BvcnRzCiAgaHcvaGV4YWdvbi92aXJ0OiBhZGQgbDJ2aWMgaW50ZXJydXB0LWNv
bnRyb2xsZXIgYW5kIHZpcnRpby1tbWlvIEZEVAogICAgbm9kZXMKICBody9oZXhhZ29uL3ZpcnQ6
IGNvbm5lY3QgcGwwMTEgVUFSVCBpbnRlcnJ1cHQKICB0ZXN0cy9xdGVzdDogYWRkIEwyVklDIHF0
ZXN0CiAgdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uOiBhZGQgYXJjaF90ZXN0cyBmdW5jdGlvbmFs
IHRlc3QKICBody90aW1lcjogQWRkIFFDVCBRVGltZXIgZGV2aWNlIG1vZGVsCiAgaHcvaGV4YWdv
bjogY29ubmVjdCBxdGltZXIgZGV2aWNlCiAgdGVzdHMvcXRlc3Q6IGFkZCBxY3QtcXRpbWVyIHF0
ZXN0CiAgdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uOiBlbmFibGUgbW9yZSBhcmNoX3Rlc3RzIGNh
c2VzCgpTaWQgTWFubmluZyAoMSk6CiAgaHcvaW50YzogQWRkIGwydmljIGludGVycnVwdCBjb250
cm9sbGVyCgogTUFJTlRBSU5FUlMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAg
NyArCiBkb2NzL2RldmVsL2hleGFnb24tbDJ2aWMucnN0ICAgICAgICAgICAgICAgIHwgIDU1ICsr
CiBkb2NzL2RldmVsL2luZGV4LWludGVybmFscy5yc3QgICAgICAgICAgICAgIHwgICAxICsKIGlu
Y2x1ZGUvaHcvaGV4YWdvbi9oZXgtc3Vic3lzLmggICAgICAgICAgICAgfCAgMjggKwogaW5jbHVk
ZS9ody9oZXhhZ29uL2hleGFnb24uaCAgICAgICAgICAgICAgICB8ICAgNiArCiBpbmNsdWRlL2h3
L2hleGFnb24vaGV4YWdvbl9nbG9iYWxyZWcuaCAgICAgIHwgICA4ICsKIGluY2x1ZGUvaHcvaGV4
YWdvbi92aXJ0LmggICAgICAgICAgICAgICAgICAgfCAgIDEgLQogaW5jbHVkZS9ody9pbnRjL2hl
eC1sMnZpYy5oICAgICAgICAgICAgICAgICB8ICA2MyArKwogaW5jbHVkZS9ody90aW1lci9xY3Qt
cXRpbWVyLmggICAgICAgICAgICAgICB8ICA0MyArKwogaW5jbHVkZS9xZW11L2JpdG9wcy5oICAg
ICAgICAgICAgICAgICAgICAgICB8ICAzMCArLQogdGFyZ2V0L2hleGFnb24vY3B1LmggICAgICAg
ICAgICAgICAgICAgICAgICB8ICAgMiArCiBody9oZXhhZ29uL2hleC1zdWJzeXMuYyAgICAgICAg
ICAgICAgICAgICAgIHwgMTY5ICsrKysrCiBody9oZXhhZ29uL2hleGFnb25fZHNwLmMgICAgICAg
ICAgICAgICAgICAgIHwgIDQwICstCiBody9oZXhhZ29uL2hleGFnb25fZ2xvYmFscmVnLmMgICAg
ICAgICAgICAgIHwgIDY1ICstCiBody9oZXhhZ29uL3ZpcnQuYyAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgMTI3ICsrLS0KIGh3L2ludGMvaGV4LWwydmljLmMgICAgICAgICAgICAgICAgICAg
ICAgICAgfCA1MzYgKysrKysrKysrKysrKysrKwogaHcvdGltZXIvcWN0LXF0aW1lci5jICAgICAg
ICAgICAgICAgICAgICAgICB8IDY2NCArKysrKysrKysrKysrKysrKysrKwogdGFyZ2V0L2hleGFn
b24vY3B1LmMgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMiArCiB0YXJnZXQvaGV4YWdvbi9v
cF9oZWxwZXIuYyAgICAgICAgICAgICAgICAgIHwgIDE2ICstCiB0ZXN0cy9xdGVzdC9sMnZpYy10
ZXN0LmMgICAgICAgICAgICAgICAgICAgIHwgMjIxICsrKysrKysKIHRlc3RzL3F0ZXN0L3FjdC1x
dGltZXItdGVzdC5jICAgICAgICAgICAgICAgfCAyMzkgKysrKysrKwogaHcvaGV4YWdvbi9LY29u
ZmlnICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMyArCiBody9oZXhhZ29uL21lc29uLmJ1
aWxkICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsKIGh3L2ludGMvS2NvbmZpZyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgIDMgKwogaHcvaW50Yy9tZXNvbi5idWlsZCAgICAgICAg
ICAgICAgICAgICAgICAgICB8ICAgMiArCiBody9pbnRjL3RyYWNlLWV2ZW50cyAgICAgICAgICAg
ICAgICAgICAgICAgIHwgICA0ICsKIGh3L3RpbWVyL0tjb25maWcgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfCAgIDMgKwogaHcvdGltZXIvbWVzb24uYnVpbGQgICAgICAgICAgICAgICAgICAg
ICAgICB8ICAgMiArCiBody90aW1lci90cmFjZS1ldmVudHMgICAgICAgICAgICAgICAgICAgICAg
IHwgICA1ICsKIHRlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X2FyY2hfdGVzdHMucHkgfCAg
MzggKysKIHRlc3RzL3F0ZXN0L21lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAgICAgfCAgIDIg
Ky0KIDMxIGZpbGVzIGNoYW5nZWQsIDIyOTMgaW5zZXJ0aW9ucygrKSwgOTMgZGVsZXRpb25zKC0p
CiBjcmVhdGUgbW9kZSAxMDA2NDQgZG9jcy9kZXZlbC9oZXhhZ29uLWwydmljLnJzdAogY3JlYXRl
IG1vZGUgMTAwNjQ0IGluY2x1ZGUvaHcvaGV4YWdvbi9oZXgtc3Vic3lzLmgKIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBpbmNsdWRlL2h3L2ludGMvaGV4LWwydmljLmgKIGNyZWF0ZSBtb2RlIDEwMDY0NCBp
bmNsdWRlL2h3L3RpbWVyL3FjdC1xdGltZXIuaAogY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L2hleGFn
b24vaGV4LXN1YnN5cy5jCiBjcmVhdGUgbW9kZSAxMDA2NDQgaHcvaW50Yy9oZXgtbDJ2aWMuYwog
Y3JlYXRlIG1vZGUgMTAwNjQ0IGh3L3RpbWVyL3FjdC1xdGltZXIuYwogY3JlYXRlIG1vZGUgMTAw
NjQ0IHRlc3RzL3F0ZXN0L2wydmljLXRlc3QuYwogY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3F0
ZXN0L3FjdC1xdGltZXItdGVzdC5jCgotLSAKMi4zNC4xCgo=

