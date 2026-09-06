Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D31B0C79F99
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 22:29:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3LMn-0007eW-ME; Sun, 06 Sep 2026 18:29:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x3LMm-0007eI-Jr
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 18:29:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x3LMk-0003lA-TX
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 18:29:36 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 686LARZF2103165
 for <qemu-devel@nongnu.org>; Sun, 6 Sep 2026 22:29:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=t5qjs2v6Mo27weEiHZeK99
 l7zWffbxgNPBDryzU/6X4=; b=PLPj6YpTsPG7t7bmfBTQNvWg8LMNV/6r1MVb1d
 JRnN++TSmxxRw5oIod3IDjFXXXUJ36sbjDEbho6vX7isuKTOJjybdN9X3yt7pIEQ
 jbdW1Nb2X8DHC63FQ2+Ko6c3qFLmg5NspeEK4fx+vyHbJ8TSiUFKKSOsf/CRYgbE
 KmsmAD8fPmMww/B4JBB7AP0gnLxjkALD1VrM7zS/tk5Ih5qa2TtevkQQN1iQYS0L
 JZWWifFpTB7pVWM96a7s8tg+4IiK8ZtbeaWZHLi55ekLgrRing6U/abHMrshLrZw
 W4KaLpWttKuzAmM/Iwz/Y8AEGssDxHr2OW9nbThNc2YoeEAg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ggba3m96n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 06 Sep 2026 22:29:29 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38ea32e57e2so5872915a91.1
 for <qemu-devel@nongnu.org>; Sun, 06 Sep 2026 15:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788733769; x=1789338569; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=t5qjs2v6Mo27weEiHZeK99l7zWffbxgNPBDryzU/6X4=;
 b=c2iFdnv6S+HXfs64SW4Y6IVnbiTytXD7XDvIlHuRDv2/0j50iGOyV8pEU1HLNeCH6y
 EJdHRxeOkgKalXrmLf0b/ZjiOmRSsYA3lyxsSFW/eQzeOIPoxYljbbrCb49AioJ2lTQ+
 77lrm3O4Te0W5gNCZ2pC0nl/PlefkFb8MV+aMNVoJMVTDr2SLfhOj4Rq2uGQPhdLbWET
 3a+UZY0rntEpveB+WtRLQrUMcwRAVqGVhNIrzLWXzf9ZPu2bbWbQY2pIrzt2E5S97Ta3
 FLzEG/WMxdZT+yHjlgLxDlxk+E0jcqiBas3JVrPQLeaAPTjRL4FaqTMmb9GZsAZZhGd0
 RzQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788733769; x=1789338569;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=t5qjs2v6Mo27weEiHZeK99l7zWffbxgNPBDryzU/6X4=;
 b=TrmWAEQWYwfgPJUIRpvrbZk0jnnV+7Ki9CaQW5SM9/j7VTnwjFgZm2IOS79JMzKV/u
 6rbmZc12JeImV0iTX4Pz0YytN3/VTLJiXaiSltB8HQ0M/Lf/FYyXFNNBNrRILjePVOyk
 n4P4oGzJczfHtev5ZoeGwLky5n97/9ANSZukorCmL/bXycN5pS8FNQeQh2l6FJib17IL
 Sww+IbPhV82ij5GgCAivUo9ruRWRoVLP/Ba3vMoT/zklPaVzIMoC/OT6njO3K9LHR96N
 GZl0ZQSVeQzKN/WC2HH3qd5KxC3MHsYDD5UEPmNLPJ+2qmoVIFPCmCHz+9rMgMSt2XgX
 yBmg==
X-Gm-Message-State: AFuF++m76qKq8RhUgBZ0brEK1tHyl57qLacs8VZZ8EgRHqdjTZGpUXfn
 UyA7WXBBtMTw3QG3F7pbFiiF6/piQBO/aLLkAfEAONz6ceGbZ2StOrfW9F6IkMYpYTnquhL/7Ps
 jv60XBmd9H0BWvPj/RAysTViH0w69eMBQPRBIetmutEJIl+Q1a4t3TbhqFc+Km1qKjA==
X-Gm-Gg: AYBFou35YVRXa6cMF7J02BmgX+Pkku8BM6iuJPJIItKkx9badnkUqYXYia95c/SUNww
 cZ0b+JsGPrX3x4Av7wYfT6ZnM45a+UxDPrspi7zmq4ywgu4l7uhamDj9NflCZPGWQHr6gwXcDDP
 k/vKR6x/wN3QJ1ZIe0albL+cQe1aVJnY2X+O5A1k9wX5ud5lrCP4M1nzuM1EKDBsCyHFJ8PjxSF
 +L9rIOhpcA8fzdT7WHI+3jqJ7/tNsHEMtej6dssa174OiDy8j+rR6wc1ZbqA0qf53l3XiUUlvhp
 15+xi3Q11RoR2UajBxlT6n2Vya9IrkRIlRNrkLokWwGCUXTsZdojq/W/mfWsz73MSEy6rdu7eu0
 MPvN3MlsTfUmfKOrALHILtCKgo+LCpetjCAcH2CVUKWFJ2iEr
X-Received: by 2002:a17:90b:3b46:b0:398:dcfe:967a with SMTP id
 98e67ed59e1d1-39b2620a2ecmr28191713a91.17.1788733769128; 
 Sun, 06 Sep 2026 15:29:29 -0700 (PDT)
X-Received: by 2002:a17:90b:3b46:b0:398:dcfe:967a with SMTP id
 98e67ed59e1d1-39b2620a2ecmr28191677a91.17.1788733768682; 
 Sun, 06 Sep 2026 15:29:28 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339ac24d7esm34956838eec.15.2026.09.06.15.29.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 15:29:28 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH] docs: bump sphinx_rtd_theme pin to fix --enable-docs build
Date: Sun,  6 Sep 2026 15:29:26 -0700
Message-Id: <20260906222926.3714852-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA2MDI1MiBTYWx0ZWRfX8zYhNfpFNB8a
 6iYVt0KtYguniP8TZ6vlC4BEmOqpaNytWYojcWyIq1tLGCtdNSaNVNJIylX57ZitLPvPSVMxreG
 F8xJbgJd8BYJjSdgeUGG8KqzKVunQm5jT0x35lTYva2btlVriJnlelLKYFFfEIxqCLoNv/s0Nh4
 PuEQgqLMiRuqijfkDNqRC0NJWhD8HVmhucwx4xeLrjwypiQs9zT/FX/Wb5i7sXGV9bA/a9E5Nv0
 IVuF4MPtqc8/pUGObTMsuChdFdvO9p6TpVkxc7AsPvAbNeLNfm0fYkoDkU/Fwt7Q3kkbLm1KnbK
 WbObuOazUx5/9yaPspBbzF8ZobH+f2B1Ntk808Wi089ow2bw743moWMLkpBG4GgIxcZG5iuPav8
 2PmfVQAxmtWFE6hurdN5pb7i6JpyGhjgFqQKo9AeDgtSG04vTJPfRaZj+eNDFb4e1rKFb/hXdTE
 mN9sbI8ehPjNcwPZSDQ==
X-Proofpoint-ORIG-GUID: zgsPejxNZlqYTfQ5dPX8hdqGRARsk4mR
X-Proofpoint-GUID: zgsPejxNZlqYTfQ5dPX8hdqGRARsk4mR
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA2MDI1MiBTYWx0ZWRfX5PnUzvLAPW1+
 z+K2V9l54KawhejQNhuR8Kyuy8Z6gekq9ti33545c0pLDf4tBEqVfQyoz/StCYdqCdXxoUdqSm0
 e/hSQ3VDG8aBMz6OgHehUB8xDO+3nG4=
X-Authority-Analysis: v=2.4 cv=Tf2mcxQh c=1 sm=1 tr=0 ts=6a9de949 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=j_Pg4yORLhztqgUJ0NoA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-06_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609060252
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

cHl0aG9uZGVwcy50b21sIGFuZCBkb2NzL3JlcXVpcmVtZW50cy50eHQgcGluIHNwaGlueD09Ny4y
LjYgYWxvbmdzaWRlCnNwaGlueF9ydGRfdGhlbWU9PTEuMi4yLCBidXQgMS4yLjIgcmVxdWlyZXMg
c3BoaW54PDcgb24gUHlQSS4KCkEgZnJlc2ggaW5zdGFsbCBvZiB0aGUgZG9jcyBncm91cCBzaWxl
bnRseSBkb3duZ3JhZGVzIFNwaGlueCB0byA2LjIuMSB0bwpzYXRpc2Z5IHRoYXQgY2FwLCB3aGlj
aCB0aGVuIGZhaWxzIFNwaGlueCdzIG93biA+PTcuMi42IHJ1bnRpbWUgY2hlY2sKaW4gZG9jcy9t
ZXNvbi5idWlsZC4KCnNwaGlueF9ydGRfdGhlbWU9PTIuMC4wIGlzIHRoZSBmaXJzdCByZWxlYXNl
IHRoYXQgZHJvcHMgdGhlIHNwaGlueDw3IGNhcAphbmQgcmVzb2x2ZXMgY2xlYW5seSBhZ2FpbnN0
IHNwaGlueD09Ny4yLjYuCgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9z
cy5xdWFsY29tbS5jb20+Ci0tLQogZG9jcy9yZXF1aXJlbWVudHMudHh0IHwgMiArLQogcHl0aG9u
ZGVwcy50b21sICAgICAgIHwgMiArLQogMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZG9jcy9yZXF1aXJlbWVudHMudHh0IGIvZG9j
cy9yZXF1aXJlbWVudHMudHh0CmluZGV4IGMxMGM0Y2Y3YzkxLi41MDlkNTZiZDFlOCAxMDA2NDQK
LS0tIGEvZG9jcy9yZXF1aXJlbWVudHMudHh0CisrKyBiL2RvY3MvcmVxdWlyZW1lbnRzLnR4dApA
QCAtMiw0ICsyLDQgQEAKICMgU2hvdWxkIGJlIGluIHN5bmMgd2l0aCB0aGUgImluc3RhbGxlZCIg
a2V5IG9mIHB5dGhvbmRlcHMudG9tbAogCiBzcGhpbng9PTcuMi42Ci1zcGhpbnhfcnRkX3RoZW1l
PT0xLjIuMgorc3BoaW54X3J0ZF90aGVtZT09Mi4wLjAKZGlmZiAtLWdpdCBhL3B5dGhvbmRlcHMu
dG9tbCBiL3B5dGhvbmRlcHMudG9tbAppbmRleCBlNGMxMGQ0YTlmNy4uYWZiMTM2NGRkMjggMTAw
NjQ0Ci0tLSBhL3B5dGhvbmRlcHMudG9tbAorKysgYi9weXRob25kZXBzLnRvbWwKQEAgLTI5LDcg
KzI5LDcgQEAgbWVzb24gPSB7IGFjY2VwdGVkID0gIj49MS4xMi4wIiwgaW5zdGFsbGVkID0gIjEu
MTIuMCIsIGNhbmFyeSA9ICJtZXNvbiIgfQogW2RvY3NdCiAjIFBsZWFzZSBrZWVwIHRoZSBpbnN0
YWxsZWQgdmVyc2lvbnMgaW4gc3luYyB3aXRoIGRvY3MvcmVxdWlyZW1lbnRzLnR4dAogc3BoaW54
ID0geyBhY2NlcHRlZCA9ICI+PTcuMi42IiwgaW5zdGFsbGVkID0gIjcuMi42IiwgY2FuYXJ5ID0g
InNwaGlueC1idWlsZCIgfQotc3BoaW54X3J0ZF90aGVtZSA9IHsgYWNjZXB0ZWQgPSAiPj0xLjIu
MiIsIGluc3RhbGxlZCA9ICIxLjIuMiIgfQorc3BoaW54X3J0ZF90aGVtZSA9IHsgYWNjZXB0ZWQg
PSAiPj0xLjIuMiIsIGluc3RhbGxlZCA9ICIyLjAuMCIgfQogCiAjIFRoaXMgdGVzdCBncm91cCBp
cyBmb3IgZGVwZW5kZW5jaWVzIHJlcXVpcmVkIHRvIHJ1biB2YXJpb3VzIHRvb2xpbmcKICMgYW5k
IHRlc3RzIHRoYXQgc2hvdWxkIGFsd2F5cyBiZSBpbnN0YWxsZWQgYXQgY29uZmlndXJlIHRpbWUu
IEl0IHNob3VsZAotLSAKMi4zNC4xCgo=

