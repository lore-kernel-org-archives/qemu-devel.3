Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 901DCC98326
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 01:58:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9v9N-0004wg-33; Thu, 24 Sep 2026 21:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9v99-0004uW-QP
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:54:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9v96-0005rW-2I
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:54:41 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P1ktST2560614
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:54:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CKXu+6FGSYFTSzdiA/RLzf21UFINfTQJytiBCTqgIbc=; b=Foirfbzb9vbnS83b
 q9iKHzONIsTnnHOSXaIaThPLV9g4EN/ZoTSNfndqh/oUJSJqcHRSPWbpvczN5FGf
 avLz79BfyLmHZzLPaJwKs1fJrFhOtiNE+J9i3l+4stxeNPlnHiJe6ZMDhcROUqmD
 B0KAcm1ZhkzWWVGGwnvKV2CExLVMhW0J3klOj6daHao6bHnDGKBVStvKbHizoNdF
 deIe46kuO7KkjSSWT0nwm4bdRXnU780L6nlHcXO6kzOFjNhoj9TpwcHCwDLUAZs3
 FSWwpUG00ZWFGMbN6jg7xK5BxYhNsnJQGgTJX14MhGm72OXxnJ4yM6DYWHRx1UxT
 k/Jhdg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw1scbfpr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:54:38 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30c0d568830so722167eec.1
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 18:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790301278; x=1790906078; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CKXu+6FGSYFTSzdiA/RLzf21UFINfTQJytiBCTqgIbc=;
 b=jua3TWewvvpRvbPZzNcFqlcnHZjmRMYvS0dWIPwI4Ljeh6/3LnxjK5NbXhtYqkdx98
 52okfuk4MomLuMk16QjMW/xKenJD2gzFz8leBtjsnOD8Bbk/XOCBBdtsVYu5gA4qBOh2
 3CP42nHq12+wJXuwbadDq022pr/Fe6KfkR+tEB3MXV/qIQQfNUTffo1MuPJzAYT6Phk+
 y8zo9hKXz82zVUPLxjNWJA0tYT31DwV7AbIIttBkCRLN8TBS6SSLaxWG2lrmTc1YBvrG
 PIsixaOGPOdtBtLY2NIy3jP00xHZtnRcaDW90I1Fbavd/yDoFP9BFUbBM3Pd4b1hVR+Q
 yKJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790301278; x=1790906078;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CKXu+6FGSYFTSzdiA/RLzf21UFINfTQJytiBCTqgIbc=;
 b=eBfeDnokItS7sT87RYTyD8mDCecO2j9P/eWErD8nBY/qLdOlKXPkqCKAGoWcsWLc6y
 R7V5en9AaRwcFenlG3BbtlFB2o4HpPH19UVsmLouAZs+jjaAxXmkISuI9j37nJ6Ux3nC
 IyNq2XfRDj4Mbklh63ov1IKHbocu2hXnp2B8qOUo/5LVRwUolKZK1t2kbRzynSoOx9Wz
 gvxrVDV89+g76B7ie4glja1NwVHDk4Cq1c4IoH45QbEuGaaFlVSHi6Junb2uGt2A6FpR
 x5JyLyzGhTQmnc0Ry7jtkFOv6rMpiK9DQRwJ+1WRodr4WWQM4GOhDrSZfcbxS35eO+9n
 F8ew==
X-Gm-Message-State: AFuF++lzDWhDElmLL0GQ7YPxRS+m+usKwW+G2Y+PCjORDBh1AHdALDZt
 ifehontuvT0sQgDPVfuiPW6TgIuCXww34Wng8bul4/sKcbFoZQNaxL7nQOwmRsBz7XuBDs62IfM
 tDYYy1wy7mTbQtiXDFLG4289DJRy+FXnwlc6FwajWUvkJ1SNs3RoNrRAsSbMJOZ0BcQ==
X-Gm-Gg: AYBFou34oWIZD4STr9K2Kkiu8p/nx5tpCXQ7JqQ8LluCE4PJ8sEBY4B7DS2gbPC4e7Z
 BQxFe8B84+sxCXuUFP39Dwzqcuo/PqOt4TV5y9dRu/DfvELOQ5v1MiFF6akix9uZ1b8pVgouuVh
 guOjIWnmGDWIWxlyBj4/CNQNicdyyW7zHY7J/3eQ4rxR9F44i7xmgX6cG4b7+G4wGZnAIEmJzlX
 /c1DkkIfoM4COSfFAW4Y0Cm2bo/tqLwMDMVe3SJsUbc5GZGVsgfxCDckFNrll3mzLBsMPaxFuHX
 ivlDd5It8y0CugpxsqaJG/lPk/MlNEHhtNc9tDLPAsxnL5zj5/nBCV4jUKqvd7GhA7vg1bRvSQs
 uZpmtEw2sGMIcgaohDs486zAngoVUiz580EU8mfV7JyOfpTc=
X-Received: by 2002:a05:693c:2412:b0:334:8fb7:1dfd with SMTP id
 5a478bee46e88-33ffe341a8emr3362663eec.8.1790301277936; 
 Thu, 24 Sep 2026 18:54:37 -0700 (PDT)
X-Received: by 2002:a05:693c:2412:b0:334:8fb7:1dfd with SMTP id
 5a478bee46e88-33ffe341a8emr3362640eec.8.1790301277214; 
 Thu, 24 Sep 2026 18:54:37 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3416e4c2f50sm1873720eec.27.2026.09.24.18.54.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 18:54:35 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Taylor Simpson <ltaylorsimpson@gmail.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 03/40] Hexagon (tests/tcg/hexagon) Add tests for
 multi-destination instructions
Date: Thu, 24 Sep 2026 18:53:52 -0700
Message-Id: <20260925015429.2579174-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
References: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: 7Dvvg-DUoxK470wUwkn-FveKuZAitiIF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfXyDeYOeby6sps
 tyKz0tZZlpyglciqNOT6HrpSDU5PgwHeUvqh8vHpggVMIXcUgCmBcdkh00nYPJvKbYif8bqM2WV
 iD8jotA6qO4FCswejpT2XaChDtrdfruh16x71t+9NrLwTEPnIVRcb1LoXVgQ4XogF+tGZ+kohQa
 JaGU80iu8ab+3EGQ657Ksju2FWg9ZLshSIBxYawX97qU/bhaMPXKxQqtiIC8ksV5PMPWAg2J+OE
 tLufLft9xmgJz8P4qjnWDQcIwTpBKviGFqVZpyME8JYIVU6d7GnCzmKsuZRg4rN8Jy8i5YENJbH
 g0Czc2HDsIFFiAGndI0688zX1DLYTfjq851xvOtMcQMIfxf/mmFUJwDOiXvonfnPx5jaOy5lTMf
 5xFFt0dGTL54EEft5QY7m2ATVI6ygRBlzZUj7Lxo3XJxQm+xRpA5gk1d7o4qeABGoIpA0k1kiFx
 L3p2OYaSIxuv5kF8iMQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfX6fk3syDIafxp
 BsdB/xJObFqbJaphz5mv86bz100lmxOciFucAdxjXUBbN61kQZjnh7D5FTL9hXh+bkDjPMYyp7c
 gs3e8ASp2vAY5/j09WbhycGDxbRHBYE=
X-Proofpoint-ORIG-GUID: 7Dvvg-DUoxK470wUwkn-FveKuZAitiIF
X-Authority-Analysis: v=2.4 cv=GI+dgeNK c=1 sm=1 tr=0 ts=6ab5d45e cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=9YL_7Jk4NeMjv8K-UJoA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250007
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

RnJvbTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KCkluc3RydWN0
aW9ucyBzdWNoIGFzIHBvc3QtaW5jcmVtZW50IGxvYWRzIGRlZmluZSBtdWx0aXBsZSBkZXN0aW5h
dGlvbnMKVGhlc2UgbWFrZSBpdCBoYXJkZXIgdG8gZGV0ZWN0IG11bHRpLXdyaXRlIGNvbmZsaWN0
cwoKUmV2aWV3ZWQtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4K
UmV2aWV3ZWQtYnk6IE1hcmNvIExpZWJlbCA8bWFyY28ubGllYmVsQG9zcy5xdWFsY29tbS5jb20+
ClNpZ25lZC1vZmYtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+
ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4K
LS0tCiB0ZXN0cy90Y2cvaGV4YWdvbi9tdWx0aXBsZS13cml0ZXMuYyB8IDYwICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgNjAgaW5zZXJ0aW9ucygrKQoKZGlm
ZiAtLWdpdCBhL3Rlc3RzL3RjZy9oZXhhZ29uL211bHRpcGxlLXdyaXRlcy5jIGIvdGVzdHMvdGNn
L2hleGFnb24vbXVsdGlwbGUtd3JpdGVzLmMKaW5kZXggODY4NjMxN2ZkY2MuLjQzMDU5MDM1NDdk
IDEwMDY0NAotLS0gYS90ZXN0cy90Y2cvaGV4YWdvbi9tdWx0aXBsZS13cml0ZXMuYworKysgYi90
ZXN0cy90Y2cvaGV4YWdvbi9tdWx0aXBsZS13cml0ZXMuYwpAQCAtMTQzLDYgKzE0Myw2MiBAQCBz
dGF0aWMgaW50IHRlc3RfemVybyh2b2lkKQogICAgIHJldHVybiBzaWc7CiB9CiAKKy8qIFRlc3Qg
bXVsdGlwbGUgcG9zdC1pbmNyZW1lbnQgd3JpdGVzIHRvIHRoZSBzYW1lIEdQUiAqLworc3RhdGlj
IGludCB0ZXN0X3Bvc3RfaW5jcmVtZW50MSh2b2lkKQoreworICAgIGludCBzaWc7CisKKyAgICBh
c20gdm9sYXRpbGUoCisgICAgICAgICJyMCA9ICMwXG4iCisgICAgICAgICJyMSA9ICMjMWZcbiIK
KyAgICAgICAgIm1lbXcoJTEpID0gcjFcbiIKKyAgICAgICAgIi53b3JkIDB4OWIwMDQwMjEgICAg
LyogeyAgICByMSA9IG1lbWIocjArKyMxKSAgICAgICovXG4iCisgICAgICAgICIud29yZCAweDli
MDBjMDIyICAgIC8qICAgICAgcjIgPSBtZW1iKHIwKysjMSkgfSAgICAqL1xuIgorICAgICAgICAi
MTpcbiIKKyAgICAgICAgIiUwID0gcjBcbiIKKyAgICAgICAgOiAiPXIiKHNpZykKKyAgICAgICAg
OiAiciIoJnJlc3VtZV9wYykKKyAgICAgICAgOiAicjAiLCAicjEiLCAibWVtb3J5Iik7CisKKyAg
ICByZXR1cm4gc2lnOworfQorCitzdGF0aWMgaW50IHRlc3RfcG9zdF9pbmNyZW1lbnQyKHZvaWQp
Cit7CisgICAgaW50IHNpZzsKKworICAgIGFzbSB2b2xhdGlsZSgKKyAgICAgICAgInIwID0gIzBc
biIKKyAgICAgICAgInIxID0gIyMxZlxuIgorICAgICAgICAibWVtdyglMSkgPSByMVxuIgorICAg
ICAgICAiLndvcmQgMHg5YjAwYzAyMCAgICAvKiByMCA9IG1lbWIocjArKyMxKSAqL1xuIgorICAg
ICAgICAiMTpcbiIKKyAgICAgICAgIiUwID0gcjBcbiIKKyAgICAgICAgOiAiPXIiKHNpZykKKyAg
ICAgICAgOiAiciIoJnJlc3VtZV9wYykKKyAgICAgICAgOiAicjAiLCAicjEiLCAibWVtb3J5Iik7
CisKKyAgICByZXR1cm4gc2lnOworfQorCitzdGF0aWMgaW50IHRlc3RfcG9zdF9pbmNyZW1lbnQz
KHZvaWQpCit7CisgICAgaW50IHNpZzsKKworICAgIGFzbSB2b2xhdGlsZSgKKyAgICAgICAgInIw
ID0gIzBcbiIKKyAgICAgICAgInIxID0gIyMxZlxuIgorICAgICAgICAibWVtdyglMSkgPSByMVxu
IgorICAgICAgICAiLndvcmQgMHg5YmMxYzAyMCAgICAvKiByMTowID0gbWVtZChyMSsrIzgpICov
XG4iCisgICAgICAgICIxOlxuIgorICAgICAgICAiJTAgPSByMFxuIgorICAgICAgICA6ICI9ciIo
c2lnKQorICAgICAgICA6ICJyIigmcmVzdW1lX3BjKQorICAgICAgICA6ICJyMCIsICJyMSIsICJt
ZW1vcnkiKTsKKworICAgIHJldHVybiBzaWc7Cit9CisKIGludCBtYWluKCkKIHsKICAgICBzdHJ1
Y3Qgc2lnYWN0aW9uIGFjdDsKQEAgLTE2NCw2ICsyMjAsMTAgQEAgaW50IG1haW4oKQogICAgIC8q
IElsbGVnYWw6IHplcm8gZW5jb2RpbmcgPSBkdXBsZXggd2l0aCBkdXBsaWNhdGUgZGVzdCBSMCAq
LwogICAgIGFzc2VydCh0ZXN0X3plcm8oKSA9PSBTSUdJTEwpOwogCisgICAgYXNzZXJ0KHRlc3Rf
cG9zdF9pbmNyZW1lbnQxKCkgPT0gU0lHSUxMKTsKKyAgICBhc3NlcnQodGVzdF9wb3N0X2luY3Jl
bWVudDIoKSA9PSBTSUdJTEwpOworICAgIGFzc2VydCh0ZXN0X3Bvc3RfaW5jcmVtZW50MygpID09
IFNJR0lMTCk7CisKICAgICBwdXRzKCJQQVNTIik7CiAgICAgcmV0dXJuIEVYSVRfU1VDQ0VTUzsK
IH0KLS0gCjIuMzQuMQoK

