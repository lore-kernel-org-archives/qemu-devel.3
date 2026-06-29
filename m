Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD0BBC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 04:30:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we3dP-0002eO-FF; Mon, 29 Jun 2026 00:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we3d5-0002dL-DI
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 00:29:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we3d1-0000kK-Jm
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 00:29:54 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T4NJrP1787776
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 04:29:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4hsqE0JDPfvXJ30nhCZ/CCXuACFuBC+IpE9moxChOvw=; b=Dew+Nd1vc04D/YTc
 qelmo8AWWHstRNbcf4mXwItwqNUyr8oaWW7o9DnvITaEfJ1miqgmHbV5U6GvwnHr
 BffyIh20NZvR8qj+q9MWzO0ERdv4Arpv6exxf57uHHyH2iaDPGpQDReH2rSboJsI
 xdQJhbk9/mP+zrxsbgi8JbO1F8CvhSQieeyg1xO0VAtNPiff2ysAmvkEVvIWkDel
 gxgzK9PAXSjCCOl3kpp8ZifcDEMwLnjBxcTA8QRWE1B8iRs6JP16/bzj3siqv/z7
 Dyg5r+qBfgi7VO+TgiX9kH0OL7X/JOIY0ZmUcozD1dQfNfVg6+MjqznsPD4H7mer
 rfEsFA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26tuvfe6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 04:29:50 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30cb2bcbf7cso2341261eec.1
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 21:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782707390; x=1783312190; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4hsqE0JDPfvXJ30nhCZ/CCXuACFuBC+IpE9moxChOvw=;
 b=VUxVlH2Es9kUEP5o/fcSt0pjHt0keRmXGhjwpPhc+0Sl5ejlD2cjHvidJIAjSaVijb
 FKAsRSrqdzyDMJBWBp049PjqJ1Te7yyT8gzUfd8DQQDH9azOtmCUfitwEDmcovlsM5XV
 JHilSjcwYA5xyzNuRBqiYak311mJ1L71WcIyXsu/WimTsjsFIYNFtkEI3BYPBO7kYEDd
 pFLIt68mXq5UPwA+hSjJ+iUhyBCtDw+UIiT/4dCyfW3tI8KpZlyrxKR8ydnVwkUhebTp
 Ir4eGkjxEF5wCdhOonj8bVLmyw2DXdsIN/H2Q11YQCSc1dv+RhpYiawXk++lrcWbsRLf
 ddww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782707390; x=1783312190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4hsqE0JDPfvXJ30nhCZ/CCXuACFuBC+IpE9moxChOvw=;
 b=SW3KpzwVwSjpyh78syLQYOG6FnSBisUBEqIRz5xK83A9Q95RzsTpRqrkZ6PsloTNOZ
 VUtrB4Daw6bNSnQlqTdVkxMmNEqvLZmJg8VyPYzXbFopaPu4RVh6bEUcBrIU0J+02Hon
 f5lJnpvofkbusGV45E6wSp8cdR6AUWZ4SW+jBFkqgJCZcY3eZJXZiGQk42eTA8My8p41
 Zda2Thlkrka1if6HQ0uFbo/3mpjzMgcdjkDnhUUGJiSb3VNp3vbVQqwEePPPQauSqpyU
 4/V1Gmxh2jLbtABt6MADKzIJeGzdMY7NcJYDiXVwLVy/VoHNnscBNUfwqxDRgpzHI5UZ
 yCrA==
X-Gm-Message-State: AOJu0YyH8A2/3V20FkBdHfgFHUMdwgjp4uSuWctxk+t5tncRI1SJ0eg0
 Xm0wPJ3EilHQ0z9u4/2Shq1oyMdr+aC7wqjPXNyO72i/fFwvw+0Ifso2Nm948sxhSG1O1moRUHn
 3yRyLYjLUpicznA5peUtIbpurCJCciWEnk8b1dB5he6V0qBRrKUCfTQz9F06+/uHDKA==
X-Gm-Gg: AfdE7cmL/bzBSIyEf2rbgLkPsb2G/C4F+NUN6kWlVzDXZQ8igL2aOX4gT+pcjtZ+mYg
 NnEN1EIrIZAdLyD4fCgTQ19FCWX1uBz40eCZjP9zUIr5i/OQaop7wC+VCFV9z/bJmhIL28VTIt8
 Z77WLlFVp3zIAwUpvf2a/oiJ9obz5X3ZZ/L/Ct5JNPSlSjd6dPYaVw9Pp2qFvLPjQhu2xphyQ0b
 5dnEOi0R3ubylWpygIHseOg2Fxsyr+dtorZqyOVAy6a1/3FzhHlM/a/uxt2IYd+w0OKgNKYklVY
 c4qHO09SDN5K7o5WJjpnSI+QtWixHjyFI37EfsWGHqm4Hiswj1BtJrH5DvRlxdOiPQhUGa1J506
 hpP2SH6Vh5XX5Sc3G8SjQh5Qwh9O3RtOjJYy3ZoQJfnBsZDX6DyScb1ilQjo=
X-Received: by 2002:a05:7301:9f14:b0:30e:d49e:428e with SMTP id
 5a478bee46e88-30ed49e51e3mr497893eec.10.1782707389568; 
 Sun, 28 Jun 2026 21:29:49 -0700 (PDT)
X-Received: by 2002:a05:7301:9f14:b0:30e:d49e:428e with SMTP id
 5a478bee46e88-30ed49e51e3mr497879eec.10.1782707389055; 
 Sun, 28 Jun 2026 21:29:49 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30d3af0d2e4sm21314609eec.22.2026.06.28.21.29.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 21:29:47 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
Subject: [PULL v4 47/77] target/hexagon: Implement hex_tlb_entry_get_perm()
Date: Sun, 28 Jun 2026 20:58:00 -0700
Message-Id: <20260629035830.1520296-48-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
References: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzNCBTYWx0ZWRfX6w/XlQztWXV0
 hly8u7jnVZ4NTV228lifmB8a9Ho54KQpqJetFQ5uFQ/GVrtKOoniGMk7s8QZ1Jj7vA0SktHOQ7o
 41T35UbhhAXPdIiJ+LSgWA5JZvCd708=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzNCBTYWx0ZWRfX1gEBxeZ1MDmS
 QxgleZGGJ8Vuko4CzwhGASsdpmv2lmNdn9sFs55Uz3heWpM7VarpAYOFgjo0nxMaVBwPRNi3Crv
 cpcFZbPhf3PB/Ar+3AuHh63XrNT4+rRvAJByH2ZKu5VhIMqz7zCW3pLQKsSKW3jv3RJY7E5QaJN
 vnf0atjV3ufK8+mk48+ZT4bl9afC4Lr/MD/sQWwXXAOUjOFo0WfeRZbH+8+phGBNGhPULC3BR0D
 ZjdNkevfHpzJDc/p8JPyl7lEBd33RKdCQUkp2uI6Hd6BexBGSO0oY48IPJBEF3Jollj4rGgDCGh
 hSCFoyQigklnHMcPu3PpHkDMma+H2/TklHuTTTrbOjeOCAL6Zc7yQQ7wE/i6xtuCz/yxR24PQ/3
 WwuYEytwJhHJEfNwfCO+GLWP9NLWsdXb6Qsd6+fJaRc3IrYEqmkxlYE8+Kl+YPverb9nR3+uma5
 XMCJjkYmivJpxeFW2Tw==
X-Proofpoint-GUID: 8yhUXllYw9XBWFtr-cTfjq4kBYxVBTOi
X-Proofpoint-ORIG-GUID: 8yhUXllYw9XBWFtr-cTfjq4kBYxVBTOi
X-Authority-Analysis: v=2.4 cv=DY8nbPtW c=1 sm=1 tr=0 ts=6a41f4be cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=RKVJoAg1yBLoogzcrgwA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290034
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIGxpbnV4LXVzZXIvaGV4YWdv
bi9jcHVfbG9vcC5jIHwgNyArKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCsp
CgpkaWZmIC0tZ2l0IGEvbGludXgtdXNlci9oZXhhZ29uL2NwdV9sb29wLmMgYi9saW51eC11c2Vy
L2hleGFnb24vY3B1X2xvb3AuYwppbmRleCA5ZjU0YzdiM2Y5Ni4uMDk1OGM1MWZiYjMgMTAwNjQ0
Ci0tLSBhL2xpbnV4LXVzZXIvaGV4YWdvbi9jcHVfbG9vcC5jCisrKyBiL2xpbnV4LXVzZXIvaGV4
YWdvbi9jcHVfbG9vcC5jCkBAIC02Myw2ICs2MywxMyBAQCB2b2lkIGNwdV9sb29wKENQVUhleGFn
b25TdGF0ZSAqZW52KQogICAgICAgICAgICAgYnJlYWs7CiAgICAgICAgIGNhc2UgSEVYX0VWRU5U
X1BSRUNJU0U6CiAgICAgICAgICAgICBzd2l0Y2ggKGVudi0+Y2F1c2VfY29kZSkgeworICAgICAg
ICAgICAgY2FzZSBIRVhfQ0FVU0VfRkVUQ0hfTk9fVVBBR0U6CisgICAgICAgICAgICBjYXNlIEhF
WF9DQVVTRV9QUklWX05PX1VSRUFEOgorICAgICAgICAgICAgY2FzZSBIRVhfQ0FVU0VfUFJJVl9O
T19VV1JJVEU6CisgICAgICAgICAgICBmb3JjZV9zaWdfZmF1bHQoVEFSR0VUX1NJR1NFR1YsIFRB
UkdFVF9TRUdWX01BUEVSUiwKKyAgICAgICAgICAgICAgICAgICAgZW52LT5ncHJbSEVYX1JFR19Q
Q10pOworCisgICAgICAgICAgICBicmVhazsKICAgICAgICAgICAgIGNhc2UgSEVYX0NBVVNFX1BS
SVZfVVNFUl9OT19HSU5TTjoKICAgICAgICAgICAgIGNhc2UgSEVYX0NBVVNFX1BSSVZfVVNFUl9O
T19TSU5TTjoKICAgICAgICAgICAgIGNhc2UgSEVYX0NBVVNFX0lOVkFMSURfUEFDS0VUOgotLSAK
Mi4zNC4xCgo=

