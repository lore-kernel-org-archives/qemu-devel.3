Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A00F9C55ABA
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 04:29:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrpi4-0002xS-99; Thu, 06 Aug 2026 00:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wrpi0-0002we-AD
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 00:27:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wrphy-0003F9-EF
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 00:27:56 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 675NcIHJ269752
 for <qemu-devel@nongnu.org>; Thu, 6 Aug 2026 04:27:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YWVviQ+H5wY7Zn6hT9cA60EmloSaszs1xldCcfSlZw0=; b=kTmvLUiIEvjaFcna
 wyFmAU1J6woFKaWZtduWmVwGYGgQvay5Uxa4ShGRJI9bnXekQsrXavHWbKzwrUTb
 Fky4Jhaa8CEbx8H3Ik4NSayIScRGmMaLNDGvb2lECaFd2WqcBczaPLSkDswVLkzy
 rPLTFcYmpugz90PCT2sZcPwrV/ZjtPTe/KPO/3IPu9z9YtS69GmBca3rZ6C5HlZ7
 RJFfLA3kwyf5n8SjA1DKrcO7E7x/OaTGzOL+0UNg0mY7GCEMJW/spWPmgxqvS15P
 SgfCkbJTPWsmDJoeXpwXcjT73BriXUpWVGFNOYclAAptuPavYh00cN6re83HW3O4
 Mf8Rxw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv3w6c1k8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 04:27:53 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-ca7c1e22995so2581853a12.3
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 21:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785990472; x=1786595272; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YWVviQ+H5wY7Zn6hT9cA60EmloSaszs1xldCcfSlZw0=;
 b=dhroDQvUyB6xfVGrtPdQLFHRAlUeC5VfHCIMJaYHz3ZvTI0HHzDeKnRz4zpjkbrmX+
 g+4KGip4rioynxFu/zlqHxudfWMIGtzqgZIyaEevm0h4UuT6BlMgMV4b2pfUHYhoZO3a
 fiG7HTJ+OtVqY5YXAcVUz6qSqNMvqBPk0lNd5xcK1FBF2i+lebHZ2kPvD/To19O2Oq/S
 enzHmGDxI5lPfbFjMh2rYym44Km/wcJxhpCYLKPDiEA6PtX+d4w0kcHBn7Tp9714/ApL
 Mde2SmraZMFZC9pi8uGeUDbUQvvVzN8/Q808tFPPBeVYxEyIu0SGQX2pS9ZmGsKNsdop
 bQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785990472; x=1786595272;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YWVviQ+H5wY7Zn6hT9cA60EmloSaszs1xldCcfSlZw0=;
 b=M1pzT82a8uF3YS3RiwgaHku7L7IXQf1owvzkZu6Glirs/mNaqKIYnXKX1h6nFexhjW
 TAm3kl/alxNCUHUaLhUSGRgSxOopbGFjJhOJNMvqxV6K8nh5maAXhE4BSsx9a408Leh8
 9wZ0SxZiZd3BB+yaS2RoZSacUPxtKaPwxKEEZbcS2jY22S9GUL+GrPhk9rCKpDRL4wxB
 J6NwOxSHJA1l9haDGHPgHEuVH6ln1ONwEd5ib345I38Appz4f338gGA3bycdu/wg/1CU
 Rjbt5zgwXbWEPq7+M4ZWGcnPlKwZVnFlJRyWSezhefasY+nhmCcLKndCFi6i0Bh5Pji4
 llIg==
X-Gm-Message-State: AOJu0YyF+lv9TerfzNGs7DNvWwoiy3u4vtvzZxOCbqJJ11yJ2w5yKRoX
 r68ZGyir9cAy1O2dFiyfdbH/cNoc6hnVxKS2Wlb1IkidB/LntwABHpPewpIU5ibUJChSOgOJVMR
 tZrl81ZyX59I0CYBggjtZa7jvZMNJeFCtyptFrCMPBqF17eMicLq4FZtEcW/dETPWgw==
X-Gm-Gg: AR+sD10SoNApFW/v78JFyZ+l12EFX7uqIin4ASVBkjfiopfxSedYcCy7sz9N+Ev9zPv
 bUPLJoy7VLlV4VaLGChZyg1OeJG0qfy/kWg2dZ8RbUPkWW8agjmuJKRD8T4ahnoTE1+0MXabJGB
 ZuQ6tsMPxfKy532VMejl66Z9+dseBGT7IXEoZdjBLqWCvoxv+szlSqhL6Ze/4gOQZeKB4wR0JhC
 HQNlgwUprAyJb9q984eDWUtYuGqWzbEKRl9cvxvgls8FVNp4KErGcWgPiRmeRfa2N7E67aFsrF1
 QvAkowcj2BXFESWpCTZTudRGFS6U0A9tuQNcc2rTHoT2HgutpB6RnyQUlvars4ta4mtjl0fryuZ
 UkjzhiePaUZSIG4Xg9ZYVqeL7NIoL5ToBojFBzGpC3g7URDF6
X-Received: by 2002:a05:6a21:32a6:b0:3c4:1916:9d46 with SMTP id
 adf61e73a8af0-3cb85eef9e1mr13352149637.27.1785990472562; 
 Wed, 05 Aug 2026 21:27:52 -0700 (PDT)
X-Received: by 2002:a05:6a21:32a6:b0:3c4:1916:9d46 with SMTP id
 adf61e73a8af0-3cb85eef9e1mr13352108637.27.1785990472145; 
 Wed, 05 Aug 2026 21:27:52 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fca926c0bsm19572628c88.14.2026.08.05.21.27.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 21:27:51 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 matheus.bernardino@oss.qualcomm.com,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v5 18/18] tests/functional/hexagon: enable more arch_tests
 cases
Date: Wed,  5 Aug 2026 21:27:23 -0700
Message-Id: <20260806042723.3785369-19-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260806042723.3785369-1-brian.cain@oss.qualcomm.com>
References: <20260806042723.3785369-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: gdcGfR4rr4JR7ItEsvrzzGuQ5f1cF7oF
X-Proofpoint-ORIG-GUID: gdcGfR4rr4JR7ItEsvrzzGuQ5f1cF7oF
X-Authority-Analysis: v=2.4 cv=a48AM0SF c=1 sm=1 tr=0 ts=6a740d49 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=6_sklNI9eh_OQcpcNH0A:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDAzMCBTYWx0ZWRfX5GaKLzoWaZ3N
 0H3oU74apuJAmXgn+WgSmyV/icc7QYnG6A8yF/99J1XFA28rtFgLBvcY33q7LXUd+IbMLWVrOU9
 4lc9/eKBh7DEF1LVCdGwAF0omvEMJk4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDAzMCBTYWx0ZWRfXyQKW42i97uo1
 3DLxwNGrOPFLNgYQ7rdi1bF8VqH1NMSg7eRXfsfQQ7tl07qdHCShaE7XUS46LIlIHuTmYuPhVm2
 TDsaI9L9ukW9GPlJqAXwQjTaEAR0u+SBChF0lR+jPDjs079YwCXtVjkFzV9GZF6QLuu94Dk7vCF
 SrrM8Shu1rIiiOCB1kY7DolfLhQu+u060IXfk9wYzJkOY8/6fM1rpQl1Z5YMt1IAzK3+dqp6qLQ
 lESGxr3B+vGAO2PvUnZ2MmLsgKi9qTM3PsqCaFz0w7dXFnxAldHgt3VSnJix68E4aN9aSMxQ83g
 PwurTTnrJ/Cxl/sG3g8qVraRzJAU3qVAloCsSdls4Jb4TVPBHV2w57y2m7FjNE5wSkW+lzB0Xk7
 ZY6AoWfRZyEqzbsomTfhkHmQCmEjqVVvoJT6sCdjbMnCrfgJklYyti0ajOpixWPDzStUZJCYlZE
 3d4+fsWdV1zxaQPeObQ==
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

QWRkIG1vcmUgdGVzdHMgZnJvbSBoZXhhZ29uLWFyY2gtdGVzdHMsIGVuYWJsZWQgYnkgUVRpbWVy
IGRldmljZS4KClRoZXNlIGV4ZXJjaXNlIGNhY2hlIG1haW50ZW5hbmNlIG9wcywgbDJ2aWMsIHRo
cmVhZCBzdGFydC9zdG9wLCB0bGIvbW11Cm9wZXJhdGlvbnMsIGFuZCB1c2VyLW1vZGUgdHJhbnNp
dGlvbnMuCgpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBv
c3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9z
cy5xdWFsY29tbS5jb20+Ci0tLQogdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3RfYXJjaF90
ZXN0cy5weSB8IDMyICsrKysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDMyIGlu
c2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9h
cmNoX3Rlc3RzLnB5IGIvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3RfYXJjaF90ZXN0cy5w
eQppbmRleCAyYmIzNGY5YjhkYy4uMDgzNDM5OGMzYjEgMTAwNzU1Ci0tLSBhL3Rlc3RzL2Z1bmN0
aW9uYWwvaGV4YWdvbi90ZXN0X2FyY2hfdGVzdHMucHkKKysrIGIvdGVzdHMvZnVuY3Rpb25hbC9o
ZXhhZ29uL3Rlc3RfYXJjaF90ZXN0cy5weQpAQCAtNTgsNiArNTgsMzggQEAgZGVmIHRlc3RfaW50
X3N0ZWVyaW5nKHNlbGYpIC0+IE5vbmU6CiAgICAgICAgICIiIgogICAgICAgICBzZWxmLnJ1bl91
YXJ0X3Rlc3QoInRlc3RfaW50X3N0ZWVyaW5nIikKIAorICAgIGRlZiB0ZXN0X2NhY2hlKHNlbGYp
IC0+IE5vbmU6CisgICAgICAgICIiIlRlc3RzIGNhY2hlIG9wZXJhdGlvbnM6IGRja2lsbC9pY2tp
bGwsIGwya2lsbCwgZGN6ZXJvYSwKKyAgICAgICAgZGNjbGVhbmludmEsIGNhY2hlIGRpc2FibGUv
ZW5hYmxlLCBiYXJyaWVycywgYW5kIGRjaW52YS9kY2NsZWFuYS4KKyAgICAgICAgIiIiCisgICAg
ICAgIHNlbGYucnVuX3VhcnRfdGVzdCgidGVzdF9jYWNoZSIpCisKKyAgICBkZWYgdGVzdF9sMnZp
YyhzZWxmKSAtPiBOb25lOgorICAgICAgICAiIiJUZXN0cyB0aGUgTDJWSUMgaW50ZXJydXB0IGNv
bnRyb2xsZXI6IGVuYWJsZSByZWFkYmFjaywKKyAgICAgICAgaW50ZXJydXB0IHR5cGUgcmVhZGJh
Y2ssIFZJRCBjYXB0dXJlLCBhbmQgdGhlIGZhc3QgaW50ZXJmYWNlLgorICAgICAgICAiIiIKKyAg
ICAgICAgc2VsZi5ydW5fdWFydF90ZXN0KCJ0ZXN0X2wydmljIikKKworICAgIGRlZiB0ZXN0X3Ro
cmVhZHMoc2VsZikgLT4gTm9uZToKKyAgICAgICAgIiIiVGVzdHMgaGFyZHdhcmUgdGhyZWFkIG1h
bmFnZW1lbnQ6IHN0YXJ0L3N0b3AsIE1PREVDVEwgc3RhdGUsCisgICAgICAgIHBlci10aHJlYWQg
SFRJRCwgc2hhcmVkIG1lbW9yeSwgd2FpdC9yZXN1bWUsIFNUSUQgcHJpb3JpdHksIGFuZAorICAg
ICAgICBTQ0hFRENGRy9CRVNUV0FJVCByZWFkYmFjay4KKyAgICAgICAgIiIiCisgICAgICAgIHNl
bGYucnVuX3VhcnRfdGVzdCgidGVzdF90aHJlYWRzIikKKworICAgIGRlZiB0ZXN0X3RsYl9tbXUo
c2VsZikgLT4gTm9uZToKKyAgICAgICAgIiIiVGVzdHMgVExCL01NVSBvcGVyYXRpb25zOiB3cml0
ZS9yZWFkL3Byb2JlL2ludmFsaWRhdGUsCisgICAgICAgIGdsb2JhbCBlbnRyaWVzLCBtdWx0aXBs
ZSBlbnRyaWVzLCBvdmVyd3JpdGUsIEFTSUQgbWF0Y2hpbmcsCisgICAgICAgIGFuZCBwZXJtaXNz
aW9uIGNoZWNrcy4KKyAgICAgICAgIiIiCisgICAgICAgIHNlbGYucnVuX3VhcnRfdGVzdCgidGVz
dF90bGJfbW11IikKKworICAgIGRlZiB0ZXN0X3VzZXJfbW9kZShzZWxmKSAtPiBOb25lOgorICAg
ICAgICAiIiJUZXN0cyB1c2VyIG1vZGUgLyBwcml2aWxlZ2UgdHJhbnNpdGlvbnM6IHN1cGVydmlz
b3IgbW9kZSwKKyAgICAgICAgU1NSIFVNL0lFL1hFL0NFL1BFIGJpdHMsIGFuZCB0aGUgdHJhcDAg
dXNlci1tb2RlIGV4aXQgaGFuZGxlci4KKyAgICAgICAgIiIiCisgICAgICAgIHNlbGYucnVuX3Vh
cnRfdGVzdCgidGVzdF91c2VyX21vZGUiKQorCiAKIGlmIF9fbmFtZV9fID09ICJfX21haW5fXyI6
CiAgICAgUWVtdVN5c3RlbVRlc3QubWFpbigpCi0tIAoyLjM0LjEKCg==

