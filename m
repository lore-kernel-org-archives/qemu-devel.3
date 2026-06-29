Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF77C43602
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 04:35:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we3em-000541-Ba; Mon, 29 Jun 2026 00:31:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we3da-0002ul-O7
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 00:30:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we3dV-0000lb-LK
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 00:30:25 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T4NJOU1780991
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 04:29:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jw9yZ1Fa+tyKZPk60MTE6s7LkPtVtmumQCTRRtdnjUc=; b=JRCRp419c8/hrK7R
 4ubCWqJll7cV64rWLZKuPLb7TtG3o9SdS4WPkgXAO1INGIwTYM50xaIqtVdy1Bm1
 WLowP6Z/2nSUJd7Vcjz4pjWwijGiZdmW7ds2kIeNyBzGxn1XXM5p2U/+AG9fw6VK
 VsCP4QzMelMdL1sBSDDcWzmr/UkuQ62URVs4LTmgXuuIZkanBa6P8Fl1EpUea7tT
 Fskl0utPF3iOYeZJYQSDFn+6x6TxTU4oXvZZyneJeBE4p8gnJ9Sd6JvkJkTsMC5e
 6vhJKZUrnF1LJfS6a+VpSly2+vMlPZJ/czz1WXwMd2guZnMO0pDDz6HMXlrquvQw
 9ZLNfQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26u74gj1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 04:29:57 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30cb2bcbf7cso2341320eec.1
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 21:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782707397; x=1783312197; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jw9yZ1Fa+tyKZPk60MTE6s7LkPtVtmumQCTRRtdnjUc=;
 b=R6igVsRAZ3tIDteWsNQJ6Iyu7dSXarvUBqQ2kXh02OzR28W23o53KLdHZqm4uiS4yZ
 i7Et1N5Zme0NTBV3vUIb4HqGNTicM9QbdsUiP1n9VEguckto+ihdM+TVGQHFxrQT3eoE
 ygupHWZV5JjfRlFsDviWK7b98zdMzy73+U74V3Eq6iqYkMneAsXdgJ7S1nlWoi1/EHfK
 eGW0bj2MvhAJIXdXevkfuYO70lgLKpvPD6iccJlFBlRzGu3oOcurOmrloVo7vjPRR8FM
 IfnBTiOroc8Vb+unnTlRc1ObVJdmDI+myDC7lfe5ViTtBvi/0O2jmJaQOJGigrudJwIU
 X/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782707397; x=1783312197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jw9yZ1Fa+tyKZPk60MTE6s7LkPtVtmumQCTRRtdnjUc=;
 b=P88sTrQ7ka/lfFdgMZp/Pc1H6+YPgr3mujNJnU0AGYbMMsl+Dx5TybQ4k40KIRwKpY
 hB3k3xjbG45MVXzkRpfcUQ82dde3ZGQ63jZWft4PJ6IkSA18BQ/78U/551+CiP4va8U0
 u7bbb+UMn1GikMdFizRXu71cRP2NVyKPfzIs/1Thyv9mFMRFI19wJN6EFMGlwQVo30p+
 fDo04wtPdEn9zXZn4CZtcPOi3acRnSIn/33JpqBVx5Yhg1x2+0wtX0l6gKtt7KC7rCXZ
 I7upNtAHjDogOhbbsIQUYudJObo9Dg6KjLJWq+sEXNBD9W3VoUymCg3alb9P7/ONA6Gq
 2O9A==
X-Gm-Message-State: AOJu0YwowA+WK5Wet5qOd/37vJoYYvuWDvoUycjHfyKR5DMiqwbsj1+T
 7CpEQQSeG6zQu8MdRhSfI2cYpKcLNJlBO98w3mwpAJIwfSIv/FI00zAW9yPWkRpUSLcMWP55TBD
 zPqXYT25pQ8a7ZaRVDRSkHVxsE3abw9bH1ilnNTUUM1U3VM2gfM+A6PFu3dJX0uXjLA==
X-Gm-Gg: AfdE7cmk3DuaIW862H2Q1fTYCknrwbne9UtdHdBsUOgs0bXJAAda3gAXR2PnCcPDXbs
 ueibDU57oprH9wsQkcWq4z/sYVeCa2yUtyMCKPkgk1HBE3bzoVVqigB11QGH5RaghML6z8mC+wz
 Bn+f0nKO7K6H0qEWpDwH12hfzzTnyQgTAXmqamG7THyG+lUgJZffiBnBaeaOFfwfaCEglLg5RMa
 gvLGhVqT/TP1cjWkvJvV38V5BueOXvbnpsYx9RnojijFS7niNjH+B/7Zd112sEPkFYjlWS7h1Vc
 0hNerCeiznTl4LK/p3QWdZBbju2Oj6g/Hnd0rcMdTtE64p8sGH4qv2Kt9QvNtWjg2uc66NOgeyi
 mQJfL+OnBFDRwVwBqxeBEvH0QIj9dwwJ9kiuH0vZ22jqGezlmuAIH3/EcG4c=
X-Received: by 2002:a05:7300:2211:b0:30e:d175:62f5 with SMTP id
 5a478bee46e88-30ed1756e6amr645171eec.27.1782707396929; 
 Sun, 28 Jun 2026 21:29:56 -0700 (PDT)
X-Received: by 2002:a05:7300:2211:b0:30e:d175:62f5 with SMTP id
 5a478bee46e88-30ed1756e6amr645150eec.27.1782707396311; 
 Sun, 28 Jun 2026 21:29:56 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30d3af0d2e4sm21314609eec.22.2026.06.28.21.29.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 21:29:55 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 52/77] target/hexagon: Implement hexagon_tlb_fill()
Date: Sun, 28 Jun 2026 20:58:05 -0700
Message-Id: <20260629035830.1520296-53-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
References: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzNCBTYWx0ZWRfXxeq/Bi/4pbhP
 kQ5NeZa/NfGJwuubJEGBHNarciHHfHtQAHsX+wgTyKKucNaucoB2r0p3YLFsDa9u154mTWkG0+M
 bgoaYva9STeURXzg4/jh6+Z76+yxqLM=
X-Authority-Analysis: v=2.4 cv=ftnsol4f c=1 sm=1 tr=0 ts=6a41f4c6 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=yz7b9sy1sBSXNk6fZdQA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: wxXRyEMx2zXnJ2YBCbCXAEvgYyVB_nv9
X-Proofpoint-ORIG-GUID: wxXRyEMx2zXnJ2YBCbCXAEvgYyVB_nv9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzNCBTYWx0ZWRfX5bWoS9Ks0ljT
 Q1fMuRDT0pQClcUKNkKMNPFPDdw0PWCXLxflqm/IUxxQ8/do7/7NuVysK482UKSY8m6RZCjETmq
 HwDp5G3irBoH4nofAcSgqD4sjX28poN9sUvlWmU6be3pORouGXUb9rsnxH/NvQa2+vZ/6zF8+J8
 ZzfpXCG8+5SqDhKMTHk19DthL+bdI4rE3X/99q2OViuNH32J8I5OeLZKKeGk7cNpprPyvTYF86x
 ml5cfTtE/EJM/yAjzrtdpHa9DkveAQIcWViUwRfODwXPt7PdYvKuLnW8nO67dgISGeORs0uISkg
 PHKM6KVPspBYzbnUKH7NWDvGfk8yzPDv8A+D/b0N/hgxi8vXNjiFmry1prnzRcCPdhL2Vc6T7T0
 vps3C4S6FlR12jiGh5PJKEF0cmEbZrmNn4QSlkWllH9XEFntmV2nKfACmTw7MzMPiHo9qM1K4Cx
 ouprezwS5bXyJ+VmBew==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290034
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Nw
dS5jIHwgMTM2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDEg
ZmlsZSBjaGFuZ2VkLCAxMzYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhh
Z29uL2NwdS5jIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKaW5kZXggZWRkZTRiMWRiODQuLjRlNWEy
NTc0NGExIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuYworKysgYi90YXJnZXQvaGV4
YWdvbi9jcHUuYwpAQCAtMzgsNiArMzgsOSBAQAogI2luY2x1ZGUgInFlbXUvbWFpbi1sb29wLmgi
CiAjaW5jbHVkZSAiaGV4X2ludGVycnVwdHMuaCIKICNpbmNsdWRlICJleGVjL2NwdS1pbnRlcnJ1
cHQuaCIKKyNpbmNsdWRlICJleGVjL3BhZ2UtcHJvdGVjdGlvbi5oIgorI2luY2x1ZGUgImV4ZWMv
dGFyZ2V0X3BhZ2UuaCIKKyNpbmNsdWRlICJody9oZXhhZ29uL2hleGFnb25fZ2xvYmFscmVnLmgi
CiAjZW5kaWYKIAogc3RhdGljIE9iamVjdENsYXNzICpoZXhhZ29uX2NwdV9jbGFzc19ieV9uYW1l
KGNvbnN0IGNoYXIgKmNwdV9tb2RlbCkKQEAgLTQ3NSw2ICs0NzgsMTM4IEBAIHN0YXRpYyB2b2lk
IGhleGFnb25fY3B1X2luaXQoT2JqZWN0ICpvYmopCiB9CiAKICNpZm5kZWYgQ09ORklHX1VTRVJf
T05MWQorc3RhdGljIGJvb2wgZ2V0X3BoeXNpY2FsX2FkZHJlc3MoQ1BVSGV4YWdvblN0YXRlICpl
bnYsIGh3YWRkciAqcGh5cywgaW50ICpwcm90LAorICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgdWludDY0X3QgKnNpemUsIGludDMyX3QgKmV4Y3AsCisgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB1aW50MzJfdCBhZGRyZXNzLAorICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgTU1VQWNjZXNzVHlwZSBhY2Nlc3NfdHlwZSwgaW50IG1tdV9pZHgpCisKK3sKKyAg
ICBpZiAoaGV4YWdvbl9jcHVfbW11X2VuYWJsZWQoZW52KSkgeworICAgICAgICByZXR1cm4gaGV4
X3RsYl9maW5kX21hdGNoKGVudiwgYWRkcmVzcywgYWNjZXNzX3R5cGUsIHBoeXMsIHByb3QsIHNp
emUsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZXhjcCwgbW11X2lkeCk7Cisg
ICAgfSBlbHNlIHsKKyAgICAgICAgKnBoeXMgPSBhZGRyZXNzICYgMHhGRkZGRkZGRjsKKyAgICAg
ICAgKnByb3QgPSBQQUdFX1ZBTElEIHwgUEFHRV9SRUFEIHwgUEFHRV9XUklURSB8IFBBR0VfRVhF
QzsKKyAgICAgICAgKnNpemUgPSBUQVJHRVRfUEFHRV9TSVpFOworICAgICAgICByZXR1cm4gdHJ1
ZTsKKyAgICB9Cit9CisKKy8qIHFlbXUgc2VlbXMgdG8gb25seSB3YW50IHRvIGtub3cgYWJvdXQg
VEFSR0VUX1BBR0VfU0laRSBwYWdlcyAqLworc3RhdGljIHZvaWQgZmluZF9xZW11X3N1YnBhZ2Uo
dmFkZHIgKmFkZHIsIGh3YWRkciAqcGh5cywgdWludDY0X3QgcGFnZV9zaXplKQoreworICAgIHZh
ZGRyIHBhZ2Vfc3RhcnQgPSAqYWRkciAmIH4oKHZhZGRyKShwYWdlX3NpemUgLSAxKSk7CisgICAg
dmFkZHIgb2Zmc2V0ID0gKCgqYWRkciAtIHBhZ2Vfc3RhcnQpIC8gVEFSR0VUX1BBR0VfU0laRSkg
KiBUQVJHRVRfUEFHRV9TSVpFOworICAgICphZGRyID0gcGFnZV9zdGFydCArIG9mZnNldDsKKyAg
ICAqcGh5cyArPSBvZmZzZXQ7Cit9CisKKworI2RlZmluZSBJTlZBTElEX0JBRFZBIDB4YmFkYWJh
ZGEKKworc3RhdGljIHZvaWQgc2V0X2JhZHZhX3JlZ3MoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVp
bnQzMl90IFZBLCBpbnQgc2xvdCwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgIE1NVUFjY2Vz
c1R5cGUgYWNjZXNzX3R5cGUpCit7CisgICAgZW52LT50X3NyZWdbSEVYX1NSRUdfQkFEVkFdID0g
VkE7CisKKyAgICBpZiAoYWNjZXNzX3R5cGUgPT0gTU1VX0lOU1RfRkVUQ0ggfHwgc2xvdCA9PSAw
KSB7CisgICAgICAgIGVudi0+dF9zcmVnW0hFWF9TUkVHX0JBRFZBMF0gPSBWQTsKKyAgICAgICAg
ZW52LT50X3NyZWdbSEVYX1NSRUdfQkFEVkExXSA9IElOVkFMSURfQkFEVkE7CisgICAgICAgIFNF
VF9TU1JfRklFTEQoZW52LCBTU1JfVjAsIDEpOworICAgICAgICBTRVRfU1NSX0ZJRUxEKGVudiwg
U1NSX1YxLCAwKTsKKyAgICAgICAgU0VUX1NTUl9GSUVMRChlbnYsIFNTUl9CVlMsIDApOworICAg
IH0gZWxzZSBpZiAoc2xvdCA9PSAxKSB7CisgICAgICAgIGVudi0+dF9zcmVnW0hFWF9TUkVHX0JB
RFZBMF0gPSBJTlZBTElEX0JBRFZBOworICAgICAgICBlbnYtPnRfc3JlZ1tIRVhfU1JFR19CQURW
QTFdID0gVkE7CisgICAgICAgIFNFVF9TU1JfRklFTEQoZW52LCBTU1JfVjAsIDApOworICAgICAg
ICBTRVRfU1NSX0ZJRUxEKGVudiwgU1NSX1YxLCAxKTsKKyAgICAgICAgU0VUX1NTUl9GSUVMRChl
bnYsIFNTUl9CVlMsIDEpOworICAgIH0gZWxzZSB7CisgICAgICAgIGdfYXNzZXJ0X25vdF9yZWFj
aGVkKCk7CisgICAgfQorfQorCitzdGF0aWMgdm9pZCByYWlzZV90bGJtaXNzX2V4Y2VwdGlvbihD
UFVTdGF0ZSAqY3MsIHVpbnQzMl90IFZBLCBpbnQgc2xvdCwKKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIE1NVUFjY2Vzc1R5cGUgYWNjZXNzX3R5cGUpCit7CisgICAgQ1BVSGV4
YWdvblN0YXRlICplbnYgPSBjcHVfZW52KGNzKTsKKworICAgIHNldF9iYWR2YV9yZWdzKGVudiwg
VkEsIHNsb3QsIGFjY2Vzc190eXBlKTsKKworICAgIHN3aXRjaCAoYWNjZXNzX3R5cGUpIHsKKyAg
ICBjYXNlIE1NVV9JTlNUX0ZFVENIOgorICAgICAgICBjcy0+ZXhjZXB0aW9uX2luZGV4ID0gSEVY
X0VWRU5UX1RMQl9NSVNTX1g7CisgICAgICAgIGlmICgoVkEgJiB+VEFSR0VUX1BBR0VfTUFTSykg
PT0gMCkgeworICAgICAgICAgICAgZW52LT5jYXVzZV9jb2RlID0gSEVYX0NBVVNFX1RMQk1JU1NY
X0NBVVNFX05FWFRQQUdFOworICAgICAgICB9IGVsc2UgeworICAgICAgICAgICAgZW52LT5jYXVz
ZV9jb2RlID0gSEVYX0NBVVNFX1RMQk1JU1NYX0NBVVNFX05PUk1BTDsKKyAgICAgICAgfQorICAg
ICAgICBicmVhazsKKyAgICBjYXNlIE1NVV9EQVRBX0xPQUQ6CisgICAgICAgIGNzLT5leGNlcHRp
b25faW5kZXggPSBIRVhfRVZFTlRfVExCX01JU1NfUlc7CisgICAgICAgIGVudi0+Y2F1c2VfY29k
ZSA9IEhFWF9DQVVTRV9UTEJNSVNTUldfQ0FVU0VfUkVBRDsKKyAgICAgICAgYnJlYWs7CisgICAg
Y2FzZSBNTVVfREFUQV9TVE9SRToKKyAgICAgICAgY3MtPmV4Y2VwdGlvbl9pbmRleCA9IEhFWF9F
VkVOVF9UTEJfTUlTU19SVzsKKyAgICAgICAgZW52LT5jYXVzZV9jb2RlID0gSEVYX0NBVVNFX1RM
Qk1JU1NSV19DQVVTRV9XUklURTsKKyAgICAgICAgYnJlYWs7CisgICAgfQorfQorCitzdGF0aWMg
dm9pZCByYWlzZV9wZXJtX2V4Y2VwdGlvbihDUFVTdGF0ZSAqY3MsIHVpbnQzMl90IFZBLCBpbnQg
c2xvdCwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE1NVUFjY2Vzc1R5cGUgYWNj
ZXNzX3R5cGUsIGludDMyX3QgZXhjcCkKK3sKKyAgICBDUFVIZXhhZ29uU3RhdGUgKmVudiA9IGNw
dV9lbnYoY3MpOworCisgICAgc2V0X2JhZHZhX3JlZ3MoZW52LCBWQSwgc2xvdCwgYWNjZXNzX3R5
cGUpOworICAgIGNzLT5leGNlcHRpb25faW5kZXggPSBleGNwOworfQorCitzdGF0aWMgY29uc3Qg
Y2hhciAqYWNjZXNzX3R5cGVfbmFtZXNbXSA9IHsgIk1NVV9EQVRBX0xPQUQgIiwgIk1NVV9EQVRB
X1NUT1JFIiwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiTU1V
X0lOU1RfRkVUQ0giIH07CisKK3N0YXRpYyBjb25zdCBjaGFyICptbXVfaWR4X25hbWVzW10gPSB7
ICJNTVVfVVNFUl9JRFgiLCAiTU1VX0dVRVNUX0lEWCIsCisgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAiTU1VX0tFUk5FTF9JRFgiIH07CisKK3N0YXRpYyBib29sIGhleGFn
b25fdGxiX2ZpbGwoQ1BVU3RhdGUgKmNzLCB2YWRkciBhZGRyZXNzLCBpbnQgc2l6ZSwKKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgTU1VQWNjZXNzVHlwZSBhY2Nlc3NfdHlwZSwgaW50IG1t
dV9pZHgsIGJvb2wgcHJvYmUsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnRwdHJf
dCByZXRhZGRyKQoreworICAgIENQVUhleGFnb25TdGF0ZSAqZW52ID0gY3B1X2Vudihjcyk7Cisg
ICAgaW50IHNsb3QgPSAwOworICAgIGh3YWRkciBwaHlzOworICAgIGludCBwcm90ID0gMDsKKyAg
ICB1aW50NjRfdCBwYWdlX3NpemUgPSAwOworICAgIGludDMyX3QgZXhjcCA9IDA7CisgICAgYm9v
bCByZXQgPSAwOworCisgICAgcWVtdV9sb2dfbWFzaygKKyAgICAgICAgQ1BVX0xPR19NTVUsCisg
ICAgICAgICIlczogdGlkID0gMHglIiBQUkl4MzIgIiwgcGMgPSAweCUwOCIgUFJJeDMyCisgICAg
ICAgICIsIHZhZGRyID0gMHglMDgiIFZBRERSX1BSSXggIiwgc2l6ZSA9ICVkLCAlcyxcdHByb2Jl
ID0gJWQsICVzXG4iLAorICAgICAgICBfX2Z1bmNfXywgZW52LT50aHJlYWRJZCwgZW52LT5ncHJb
SEVYX1JFR19QQ10sIGFkZHJlc3MsIHNpemUsCisgICAgICAgIGFjY2Vzc190eXBlX25hbWVzW2Fj
Y2Vzc190eXBlXSwgcHJvYmUsIG1tdV9pZHhfbmFtZXNbbW11X2lkeF0pOworICAgIHJldCA9IGdl
dF9waHlzaWNhbF9hZGRyZXNzKGVudiwgJnBoeXMsICZwcm90LCAmcGFnZV9zaXplLCAmZXhjcCwg
YWRkcmVzcywKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhY2Nlc3NfdHlwZSwgbW11
X2lkeCk7CisgICAgaWYgKHJldCkgeworICAgICAgICBpZiAoIWV4Y3ApIHsKKyAgICAgICAgICAg
IGZpbmRfcWVtdV9zdWJwYWdlKCZhZGRyZXNzLCAmcGh5cywgcGFnZV9zaXplKTsKKyAgICAgICAg
ICAgIHRsYl9zZXRfcGFnZShjcywgYWRkcmVzcywgcGh5cywgcHJvdCwgbW11X2lkeCwgVEFSR0VU
X1BBR0VfU0laRSk7CisgICAgICAgICAgICByZXR1cm4gcmV0OworICAgICAgICB9CisgICAgICAg
IGlmIChwcm9iZSkgeworICAgICAgICAgICAgcmV0dXJuIGZhbHNlOworICAgICAgICB9CisgICAg
ICAgIHJhaXNlX3Blcm1fZXhjZXB0aW9uKGNzLCBhZGRyZXNzLCBzbG90LCBhY2Nlc3NfdHlwZSwg
ZXhjcCk7CisgICAgICAgIGRvX3JhaXNlX2V4Y2VwdGlvbihlbnYsIGNzLT5leGNlcHRpb25faW5k
ZXgsIGVudi0+Z3ByW0hFWF9SRUdfUENdLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0
YWRkcik7CisgICAgfQorICAgIGlmIChwcm9iZSkgeworICAgICAgICByZXR1cm4gZmFsc2U7Cisg
ICAgfQorICAgIHJhaXNlX3RsYm1pc3NfZXhjZXB0aW9uKGNzLCBhZGRyZXNzLCBzbG90LCBhY2Nl
c3NfdHlwZSk7CisgICAgZG9fcmFpc2VfZXhjZXB0aW9uKGVudiwgY3MtPmV4Y2VwdGlvbl9pbmRl
eCwgZW52LT5ncHJbSEVYX1JFR19QQ10sIHJldGFkZHIpOworfQogCiBzdGF0aWMgYm9vbCBoZXhh
Z29uX2NwdV9leGVjX2ludGVycnVwdChDUFVTdGF0ZSAqY3MsIGludCBpbnRlcnJ1cHRfcmVxdWVz
dCkKIHsKQEAgLTUxNyw2ICs2NTIsNyBAQCBzdGF0aWMgY29uc3QgVENHQ1BVT3BzIGhleGFnb25f
dGNnX29wcyA9IHsKICAgICAuY3B1X2V4ZWNfaW50ZXJydXB0ID0gaGV4YWdvbl9jcHVfZXhlY19p
bnRlcnJ1cHQsCiAgICAgLnBvaW50ZXJfd3JhcCA9IGhleGFnb25fcG9pbnRlcl93cmFwLAogICAg
IC5jcHVfZXhlY19yZXNldCA9IGNwdV9yZXNldCwKKyAgICAudGxiX2ZpbGwgPSBoZXhhZ29uX3Rs
Yl9maWxsLAogI2VuZGlmIC8qICFDT05GSUdfVVNFUl9PTkxZICovCiB9OwogCi0tIAoyLjM0LjEK
Cg==

