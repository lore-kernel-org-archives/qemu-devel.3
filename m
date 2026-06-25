Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79FB1CDB479
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:50:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wclNa-0002e5-PV; Thu, 25 Jun 2026 10:48:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wclNU-0002c0-V8
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:48:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wclNP-00005x-4V
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:48:26 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P9k3ZE1755363
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:48:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4hsqE0JDPfvXJ30nhCZ/CCXuACFuBC+IpE9moxChOvw=; b=Wz1pBwEGXvDRNXGr
 IPTEnU8cPnjGzgn6vgYZEQkcxV18vbVbzu2EBCZ5lX1TDCBoVqkiamjvgzA11Qnp
 4XmGSFCQ8mppHrLCdZnKz3SxDHQLOw+5UfnTlsKJQvuYednkQmzVdDosB6B1DS1Z
 ctSv0+LBQ2OHyOOE1eJTwDMmmFqW+kD/yLeXR0XyYCdvPApLZ8NIinzRbmAupc8d
 iRi+fWTleGnQu2WLg/OtkmZcmjeESovzmLIYq3LNC2dtjcPgqO9BCR+LOzX10Q16
 lGpVN1bT+vvvzusNQ/WOnJH8bUeOJkLD6ldU67cmi+v+Xyav4OqWYc8CLRSgrMJF
 iSNj0g==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0w0q2byc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:48:19 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30c95b0e22aso75514eec.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 07:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782398898; x=1783003698; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4hsqE0JDPfvXJ30nhCZ/CCXuACFuBC+IpE9moxChOvw=;
 b=M16eXiQxhjdTX0zH3Q4IYoFyTHcrQZdC538t7nAsMjsRQoJ40hxkY9HnR7ypmkQ9LK
 u21o2bNWzOtLz3V2bfCo+AIe7OXqt6PGoBOFcy9vhopYQbEBNnARyRAhE+jkQ+e30ITN
 yfru5TyAs90ijXngiSlr1SiyoXgPLkF126SqKr4aJ1d0kgA66fnz7/NeCfIqggi2KFWV
 +OabP+ywBd/MjOTTNpAVk0powbHUy/YeRb0z9TS4I/papyT5QxAUrcYo7JgJPqIq6n78
 7ozHB8DYnIKDu4Pz8i7GrEKnyvNhCkMv5yoz2N9doeJSLzwE29X6eUUt3566VDXBfIba
 fZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782398898; x=1783003698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4hsqE0JDPfvXJ30nhCZ/CCXuACFuBC+IpE9moxChOvw=;
 b=HJvWyoMOFnXBW/3NoRcXz5tkKN830oKqiY7RHSbR7z+Qn2smGsKSfKXmJJox8oczjN
 djDIwNwneE2hNYh2tcBNZwa58iMuK3gdKbFRuwjj/9GPnQS1RisZNWL0JcZ9AGSuMm8l
 yPTis/TUU8GrUYd1oOEaBYZEhnydPoFVCvql76pPtLQfnw8P2IyoqoF2NYpYs0VWB01w
 74fKrNUfthY5s8pu8puS2L0Qo/oocYm82Bt1vB0ywy4eiTMwr4oR16mXwQmkyjhhs8Ap
 xyVweQ4vbJUZvjLoakZOCcOzaGaPAM/gcM4OL+kQZwglFe0Qo+VtMgcvoGvz8g1BB+pI
 EgVA==
X-Gm-Message-State: AOJu0YyUhkDGskN92+FRel12vQzXQvGO2WJbBNZFEC24+ianrkl7VuSZ
 SRmdb4ykfH8sDbxeomnVKX/zKJjACf2Q/2J+lIhzjh5FE+6fULeVX8xLmI4Oc8mjzQ+Oc4CkIIV
 Rnusz6YhZSnLBP/gtce6ilwRwLGhos90/Iazpno3irr6gRbP8wJbDvIYkgbFT1nVGBQ==
X-Gm-Gg: AfdE7ckcIWYd+Ms87ypNg2eV865ES9vZW1ql537lHuQDzOjb97xF8dB1o5oKm6rn7F7
 N7Fbv5JLDYwvfU3ZdXOGLlYYisHGZmopPQwO6uxKLua5t1fLcJfAG//Fkm/ek9TV5Wu7Wv89KC0
 r4TKvk0o3lXw1VpSSiH1uOdu89QU/B1hfdmbMNmGb8B8bMOXHWrNUO1K6o77odblEC1U3vUrFCr
 7xQtAK3eYhzCqaPOXDWtzAeiMwh87ZuqlWXML2PB6fDq3wetMB/GD22LdcnHxkT9coPVxhRsdAa
 QlkxAhF7NhO0rVAC76z+S9wUd/QalFVxFRNvY9U6GWAPP8QsXnXziiUkx2FpMsKx2euRkQ0qGqS
 eRzUDB4A0bldNXFFHUBNdWk2x604WiPGCXH80+Yj0fMVYMx/rZw+Lw+T4hjo=
X-Received: by 2002:a05:7300:fd03:b0:30c:5534:e6f1 with SMTP id
 5a478bee46e88-30c84e3157bmr3042825eec.29.1782398898317; 
 Thu, 25 Jun 2026 07:48:18 -0700 (PDT)
X-Received: by 2002:a05:7300:fd03:b0:30c:5534:e6f1 with SMTP id
 5a478bee46e88-30c84e3157bmr3042776eec.29.1782398897671; 
 Thu, 25 Jun 2026 07:48:17 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8afca8sm8999209eec.17.2026.06.25.07.48.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 07:48:16 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
Subject: [PULL v3 46/76] target/hexagon: Implement hex_tlb_entry_get_perm()
Date: Thu, 25 Jun 2026 07:16:03 -0700
Message-Id: <20260625141633.449487-47-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
References: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: BbvH6sPtB3Vv56RvrxfwDSmlVmT7xm7u
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEyNiBTYWx0ZWRfX2KljqNYADdAU
 F5spuqk2hAzh7Ynac3jtLCv7r6cA5/9Rwc2JVlbwDpCJ1m2Pbi0zskfn0a98LcHF8/DswXqHiwh
 8BCv4xlTGa70I8uQCjPq/G6+4QsPu3A=
X-Proofpoint-GUID: BbvH6sPtB3Vv56RvrxfwDSmlVmT7xm7u
X-Authority-Analysis: v=2.4 cv=R6Ez39RX c=1 sm=1 tr=0 ts=6a3d3fb3 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=RKVJoAg1yBLoogzcrgwA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEyNiBTYWx0ZWRfXwNpNfUuRhaqA
 eLuStUzYL2saK4GdbM/ZQD2wn2yf/3F8woHasJtqiwqyyafw0i3S4N+fWqMcOQjVIhPg5g1HCaw
 cDqC+R7wGVAKPLY2q+uMayEOqRsAS9xgFo0e1z2mw2z7YqKFWtnzDAQyh5U4dXCO/7Gi0SvSzU7
 DbK6vs6sNlNcIez6JDathjWocLyBEHV3mJQItg5NbQ/P6qV+fF95jTYSqWzyzdzjezKWDsAFbpG
 Gz3C6kFfS739og1sKprtDvlvG7DilqUL3xb4Y6q3oGEq9UE+jvnwJL64+tUxfuOnkM2zMjMsn7C
 b4EmHGgDEdD9chkjaOo9miBInqtz3T+oBvK6kOX1yWIjv986yuwNcYDEMFPFmkByQLfOzmNKotP
 pJW/LYlUItX0GVC8nYPCu0sXeAsRXJ0SXR/tKBEJgY53Mk6W3mL5Z3Gndcs07KzGek81Mb/7hRM
 8p1GhI/jDoSZeWULl5g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250126
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

