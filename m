Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAFBAC44506
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 23:08:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whxpp-0001TS-Ll; Thu, 09 Jul 2026 19:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1whxpm-0001Su-Ko
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 19:07:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1whxph-0002JF-9X
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 19:07:10 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669HYDgK2476568
 for <qemu-devel@nongnu.org>; Thu, 9 Jul 2026 23:06:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jTPIBV7iqMkmA8+g9iyjWw40FvNik0ck5XTSwWcrR6s=; b=Q13E/B6SooZtzibi
 2ri4DZ1k5Px7OPYEO+M/eCeQ3LBeD929E/Ia4tKjWvp9A+TjSZr8Yp3AIuHvPExR
 EzR+t5pRb9uOFMLFKPCUQ2aNFSbg5oiWsjCLD/WJj5swL06I9TZAaCFhRQ94OIi/
 0L6e7cNZSEO/+MBdAXPg+bR3iM45W7+B/+cUWtcAlczv4fJej5N6kYIY7jtckvxf
 EoDPPD+glIVRbYspAqZpi/7pAR1C2SdQZPy6ZYqNm+RXaDAVH5v9sp7zWM3UILv7
 hxnfux2s4tzPQLBjGgKhTCrg2PaPTtmjvoJKEB44Stc97KEu3WL5PzezlkRbGvXa
 BSlVjA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faf5msgwq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:06:49 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-381250979d5so428916a91.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 16:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783638408; x=1784243208; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jTPIBV7iqMkmA8+g9iyjWw40FvNik0ck5XTSwWcrR6s=;
 b=F5th8JmzaAd4KWMp/7qhhjkPtEg7oGsj5PEkOFAUtO6xIEk3Qe1sNESaCSy1P+cJPn
 yX3xTKCUu8HAKJ0x/dBvzdCE+KRoLBrSYMYXuUhnqntPvyV6CHeq4O38IKOUQ/VqY7/6
 Egt0lqAvYArM3sNn5/r35k/B88xa+4HKdIZDTX4ikPxuHlZxjQYceFtSRxNpDbVne4+p
 93bHrLiNGkErYYMiK9FcPMx+VoRPgSJPXHKNPIvqEt35lBeGwTJPvfPTE0kolXTcIPOh
 d72RtPxIyrt6y92kW3NcRrz3mzw5Nv3+NYGcaUyN9GUMzVI6kkZPQJkY+xuGILcasQoQ
 Q8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783638408; x=1784243208;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jTPIBV7iqMkmA8+g9iyjWw40FvNik0ck5XTSwWcrR6s=;
 b=J4EbVeH0D/cnTOSl9OiJnH3Hm1zSyD1AW5LCGhGE77StnaLXN36ICfEgRNAuJ0m3s1
 WrlRU5YiFHwN704SUojlTTD76rZW1+lP2ePsw7lkOahz/5TE+MTbEDKqtihlHqOHuT3w
 TR8Hrjg21rFVxFr6qd9w+HV6wxZk3cfXbye207p7M1jTHl6FJD74zP0eNvZXsIlPXA9a
 K/MYVnfonQhVGcD/bXLCdOt+fR7yxqdQzuzRFnjUMCLXbc6cClGYF2U80s0CjH6dVXID
 kPrLRrcRQUqIkbz7RxL4lZHtJsj9eI7CKrSq4CUDb/x8sxalH73hIztydN8hzi69IZqf
 zb7Q==
X-Gm-Message-State: AOJu0YyRIihT5jKyzD2EFwXxSUj57HSmPpr94MS9pZ95T17TMnM3Q8YI
 p9rPKSpMdUJQM0LB7dFDsQs9TNUiJ7kGAy9QCg25etjjaM2CQzPu11mACK3A2OqC6JjWDve2lM9
 1ui+rWxZ55iVAY3E/hT17ZfrrppE+hG774crLIp37IQ0UEGFKiiLeWr1JY6n3jau8tg==
X-Gm-Gg: AfdE7clO45ZG5uCU06r2s0CTT6MgydgiBSjzXm20EMR9tyk+L9xwWIaozdan8Q67vI1
 YaSKNlVIqp8JGdj+NZVgYS2ZAdnW09ECG3BPCyi08CXVb3wal0ZoEDjNHZc3OGzeOj/gYDI/II+
 HlwdRKnbe2lpMkoXfoUahHJ7ptzjuFxGyKhp/TKaO8TlLbmicGEJpayga2BwHR5Qz7os5+96WjT
 s8oTK2drgNCiBATRJ25kSQU/J7uC0PIZoTnJaJOOqZakFjaV1yWv3RDHwUtU/vHG7YM9X9XgbAU
 W4m88OSeeW8IkFscziY4ohonNtDhg+CtUSzBe89mp9UT2KI7V05jMV1ZMKeJQKbErqyievfB0gb
 RvACC0ITp+ENJ72UyoVcgoJOk1H6e9qi0WYIruWHi9nnub/zYj9YOqGyep+s=
X-Received: by 2002:a17:90b:4c:b0:37c:8628:f79e with SMTP id
 98e67ed59e1d1-38940248a3dmr9393104a91.16.1783638408292; 
 Thu, 09 Jul 2026 16:06:48 -0700 (PDT)
X-Received: by 2002:a17:90b:4c:b0:37c:8628:f79e with SMTP id
 98e67ed59e1d1-38940248a3dmr9393090a91.16.1783638407855; 
 Thu, 09 Jul 2026 16:06:47 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31198cb2b99sm15770348eec.26.2026.07.09.16.06.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 16:06:47 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH 1/2] target/hexagon: initialize deferred sreg-write temps to
 current value
Date: Thu,  9 Jul 2026 16:06:44 -0700
Message-Id: <20260709230645.3033240-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709230645.3033240-1-brian.cain@oss.qualcomm.com>
References: <20260709230645.3033240-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: NQ6KTwNbaRnCxIs-H4kC8Ws7sIX_dgLV
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDIzMCBTYWx0ZWRfX3vtFm38KGBno
 nIWAwI+IezEfw7c0iU3gCKGxu/1elR/+NFACgbwpva0e4B0YAcy8LAcgk7EQJJ2AUR8FVzLhxhv
 cLQ6fkWErAgPjuBifK8MKIHIJaxMiIs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDIzMCBTYWx0ZWRfX2Ei/5Vq1izuU
 kq9jS9N7vfbhKyFCnu1s6LmXbJRua4af2crjxVCeQFZMjdVX90h+xway8a8yxvagRt8IPNNuxwn
 g39tHyd90zSZRbtsbUZPjNuUPy5bmZrFRHS2LBDakcnIWhosidCSVnwaQE6cHKWq2wSqJOIURv6
 ndTK4bsOmAXgWkl/JGiSD5eP4uEr782kaw2hfZo8mt8C+UNDSe72i5dO83sgVFQj6JGJoNBpXQM
 GD6FGpCaQ+CC0IM8L2tLL8Yf+2h6hn1ji7wzUj0IHoIlXcvpH8cKE8b/ZrTKx0/rZLDB2zBBsjN
 6orcxJUiYgOlDQgIllxd5qUKS5mspmIPtSu8NDEC59NegL+SiQDMYhOcTLpZlC0wpLgicPZfNYV
 ZjDAWIrC8P2hQ8zRE4BFWlLXwtwaYEl4Bo02GJ+XCQsH8zhyPAROX7X17lxj1lCmQTLGCesSyYr
 DuIPXGV29l4jlvmeiXQ==
X-Proofpoint-GUID: NQ6KTwNbaRnCxIs-H4kC8Ws7sIX_dgLV
X-Authority-Analysis: v=2.4 cv=N+QZ0W9B c=1 sm=1 tr=0 ts=6a502989 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=IlOZXNdbeIrMSDKviAkA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 phishscore=0 adultscore=0
 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090230
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

VW5jb25kaXRpb25hbGx5IGFsbG9jYXRlIGFuZCBpbml0aWFsaXplIHRoZSB0ZW1wIHRvIHRoZSBz
cmVnJ3MgY3VycmVudAp2YWx1ZSBmb3IgZXZlcnkgbG9nZ2VkIHNyZWcgd3JpdGUsIHJhdGhlciB0
aGFuIG9ubHkgYWxsb2NhdGluZwp3aGVuIG5lZWRfY29tbWl0IGlzIHNldCBvciB0aGUgcmVnaXN0
ZXIgaXMgU1NSLgoKV2l0aG91dCB0aGlzLCByZWFkaW5nIGEgZGVmZXJyZWQgc3JlZyB3cml0ZSB3
aXRoaW4gdGhlIHNhbWUgcGFja2V0CmJlZm9yZSBpdCBpcyBjb21taXR0ZWQgY2FuIG9ic2VydmUg
YW4gdW5pbml0aWFsaXplZCB0ZW1wIGluc3RlYWQKb2YgdGhlIHJlZ2lzdGVyJ3MgcHJlLXBhY2tl
dCB2YWx1ZS4KClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxj
b21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyB8IDUgKysrLS0KIDEgZmls
ZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
dGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYwpp
bmRleCA3NzIzNTkxNmY0Yi4uMjhhMTcxYmY2MjMgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29u
L3RyYW5zbGF0ZS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCkBAIC02MTUsOSAr
NjE1LDEwIEBAIHN0YXRpYyB2b2lkIGdlbl9zdGFydF9wYWNrZXQoRGlzYXNDb250ZXh0ICpjdHgp
CiAgICAgfQogICAgIGZvciAoaSA9IDA7IGkgPCBjdHgtPnNyZWdfbG9nX2lkeDsgaSsrKSB7CiAg
ICAgICAgIGludCByZWdfbnVtID0gY3R4LT5zcmVnX2xvZ1tpXTsKLSAgICAgICAgaWYgKHJlZ19u
dW0gPCBIRVhfU1JFR19HTEJfU1RBUlQgJiYKLSAgICAgICAgICAgIChjdHgtPm5lZWRfY29tbWl0
IHx8IHJlZ19udW0gPT0gSEVYX1NSRUdfU1NSKSkgeworICAgICAgICBpZiAocmVnX251bSA8IEhF
WF9TUkVHX0dMQl9TVEFSVCkgewogICAgICAgICAgICAgY3R4LT50X3NyZWdfbmV3X3ZhbHVlW3Jl
Z19udW1dID0gdGNnX3RlbXBfbmV3KCk7CisgICAgICAgICAgICB0Y2dfZ2VuX21vdl90bChjdHgt
PnRfc3JlZ19uZXdfdmFsdWVbcmVnX251bV0sCisgICAgICAgICAgICAgICAgICAgICAgICAgIGhl
eF90X3NyZWdbcmVnX251bV0pOwogICAgICAgICB9CiAgICAgfQogICAgIGZvciAoaSA9IDA7IGkg
PCBOVU1fR1JFR1M7IGkrKykgewotLSAKMi4zNC4xCgo=

