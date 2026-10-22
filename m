Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F693606A924
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 18:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mYWrnb5I;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fyBByM7W
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJxbY-0006W3-Ue; Thu, 22 Oct 2026 14:33:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xJxaB-0006C4-N4
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 14:32:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xJxa9-0002eb-VC
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 14:32:07 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MHtTEG387600
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 18:32:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Vvu9zBmeiG5IdSolQTzttEOvEX3GYy/D7ZOye8S8kUw=; b=mYWrnb5Iurscl1Ye
 63M5pKoR8QVm+M4qYncRfu2ojP2b+j6lHx/GwE6JmKUhVOSnjtBnsZNUJvpZ08Ps
 tHAhiKNoXY4vux7bxlKUSCrR6qPEVS7NA+GtdxqZKOqXqLviwxSOdXoTT73KW/Uf
 +XdCz03TmFBNRktcfFkA75/UFY64meps2Fc6gy0FpIBwIVVNZvp8D41qjPUbKfWj
 wVlslfRmVrR2APwtIjl+ddMcNW5pnwQ8gaWqboaZZfOR4DrriKM8SVcDbw6SLo1A
 BSqgAAQVt0i7+ttuCQVU/m7sxT0JkFhlRCbyWAQdXk7E5n5uVGYnYZdUSob98kQG
 t3heag==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfewq42th-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 18:32:04 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3698bd5392cso31866eec.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 11:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792693923; x=1793298723; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Vvu9zBmeiG5IdSolQTzttEOvEX3GYy/D7ZOye8S8kUw=;
 b=fyBByM7W0I+ydNSU/0m6qkmxHNGijIIMtM3mxnUv1BjPeeYHrPGnwNBXqACpa+HL/6
 ZuXLWjml8k3QROxN7CeQL5e+RKO2de/uW2FOAAilAC2b3+11jNaDmO9bZkjgTbMX/qz5
 ArPwSs39VcX9QOVdC+4mMiB5nzRxpb+cTXLRlIqxj2DxWvZrdBDws9bTLu3DUtlEPD7O
 E9F+YZnJUf7logfZNnnAw94Uhdlll4HoaToMV3I+9VHCihzkR6q7EOYlPy6Tj1H8/8n6
 7LmBs0oBcPWFqeVeNzuGRpF88KUyg/X3+nEghm3gnkntj4gIWl5XkW8kqB9DXjXcCnj7
 sgnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792693923; x=1793298723;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Vvu9zBmeiG5IdSolQTzttEOvEX3GYy/D7ZOye8S8kUw=;
 b=BNN3a6/ee8vb5yXWeh4rglpyOp+HXSGKauc/CzQEhBd1uyXqLeFtJtQGHFEn1GYkDJ
 3DjjTqkFh1hEs3EEofNRpPdUotlDmnKVlFuOU90iWnZxqQFh+J/Fx/8I+f1sKDFJutKY
 DtJ4cV5GqF1mSrdBAYdLRNTShfu0ypt1Bm2mKkiiZ2SasbUV1dlf41ACewY7clrh8ewr
 7dSI0l77VElCqg/3rj3DfCxIi+7/x41sW3azKiYf+Pw2yADq6x8gWN7vMV2PUQSvFRFw
 FeM6Er9ZaD03ryKwfoe/6vtzVhUCdrxegpWqj6uBO4pQE59JBd8UhuJ1e/TUPTMeeGOZ
 uLTw==
X-Gm-Message-State: AFq9FYIUUzlA0fFh/NKWiRlOIyQTxk4jBKC7l1uKfyF9jCaArEIzsVoX
 /o0JzSVtawVJWq2lUFl/WTEce5E2I1d+Fo8jTWl6pTWZbrwPRWEqAU1ak90dfavsnvadK8ELv1w
 6LSWMk/6Dl0Jfn9c08SXNauOpqiD5B6SsC7J63Uf5VVbM/ejflCHekeQswr8H4tp7SQ==
X-Gm-Gg: AYBFou1sdC12fcTIkszjocIuV83cy6E2Iqn8r7UaPLKh0a/D7lXLZgpFFLnJCvwXd/q
 MSEpnwA6k2UUBNmChZxFmXl3oUnpZ4RW3kw6sAEasX+QmmAnQ0YB07n4NBt3RHXDQTwL7yNJf8+
 0wWqV6WnrThgcgTaByU0EBxAUHOpCZsUQbK09SVjyEsxKXc2r3b7/EM0QhMCh/30Exs4De3mRJ7
 RuW8r8AMP9/XAjfNnSGXkXpEvuUy6No38AnzJvV3fF+kPB7kz8hSy3zU/k60/NQYYtrtKtdlDBu
 +0R/aLbWTr2cSHjcCjML6Mym09EwT05vXHGdqT/B/+x/WDsQ7NReg2dSinoS3pJDVaaQtYai4fV
 jFjB6wSXoT2LZzvOhUrYR66DQxOrH4ZHRtoizUecAyfUgVtdq
X-Received: by 2002:a05:7300:c00d:20b0:341:c383:9afb with SMTP id
 5a478bee46e88-368b0d3cefcmr4267720eec.20.1792693923101; 
 Thu, 22 Oct 2026 11:32:03 -0700 (PDT)
X-Received: by 2002:a05:7300:c00d:20b0:341:c383:9afb with SMTP id
 5a478bee46e88-368b0d3cefcmr4267697eec.20.1792693922540; 
 Thu, 22 Oct 2026 11:32:02 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369d8f8eaf9sm44962eec.16.2026.10.22.11.32.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 11:32:01 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Mohamed Mediouni <mohamed@unpredictable.fr>,
 Alessandro Di Federico <ale@rev.ng>, Laurent Vivier <laurent@vivier.eu>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH v4 07/11] target/hexagon: reject reserved L4_loadw_phys
 encoding from v83
Date: Thu, 22 Oct 2026 11:31:43 -0700
Message-Id: <20261022183147.1535585-8-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261022183147.1535585-1-brian.cain@oss.qualcomm.com>
References: <20261022183147.1535585-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: gwX3RCMGF5TY7i-j_2rYscuE9OcunII3
X-Proofpoint-ORIG-GUID: gwX3RCMGF5TY7i-j_2rYscuE9OcunII3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA3MyBTYWx0ZWRfX889ciTe75+wy
 RPiEw1HLcfrE4vp/2WJB/TKo6VTT02ci1pKjIEYBItrvV2fkLBzSziFviMG08rIbbQxKMpSCfgT
 L8LgsoOlqs9lTCHMgTf+1QOSXpaMhU4=
X-Authority-Analysis: v=2.4 cv=G4OJgNk5 c=1 sm=1 tr=0 ts=6ada56a4 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=EkHQ-IOB5RTo-Ixd14sA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA3MyBTYWx0ZWRfX8dAf5H7CnRQB
 wYZPj2wg2jGOW6QLlmesAzcD37RIYnVJmsWgN7DrL854c6QQHp5OaTVPuQE7cujYIL7pap1n8fz
 T8Q/cZeG+wBxowvwKk6pWZkrvgDIefYPErfaJn5SCUzf6+dfv0lP69JGuJ36qGoiIB+b0l6Q4XL
 CHU+596ihzWTdJTcTOUzeq+78XUGdH6bH3mKDwP6ggCUJHKlR7D79aK++ap0p6lCTttMlSQheDn
 alioOX85TTBewQ3KrGabvq8Ju87O4cSWUzT+cFVI2omKXplkIHhKrE5Jw6Ir1EGhiLJjpSnX7rC
 tX9uTC2RmwTEhdtasGajWUUzTSStKmaGYMPRipENt3AMBL8E3b3sWcEQwbnNoZGyTxJSArGpf75
 iVF97YC7JSZq/7H6YFGyd8pZmdA8QQU6qnUbSfrLup8aoAFXeMvqH3zEIBBTvAX3PimngemJtMn
 af1lWMj0XD4zx1lINIA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220073
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

Qml0IDcgb2YgTDRfbG9hZHdfcGh5cyBpcyB2YWxpZCB0aHJvdWdoIHY4MSBidXQgcmVzZXJ2ZWQg
c3RhcnRpbmcKd2l0aCB2ODMuIERlY29kZSBpdCBhcyBhIGxlZ2FjeSBkb24ndC1jYXJlIGJpdCwg
dGhlbiByZWplY3QgaXQgZm9yIHY4MwphbmQgbGF0ZXIuCgpSZXZpZXdlZC1ieTogUGllcnJpY2sg
Qm91dmllciA8cGllcnJpY2suYm91dmllckBvc3MucXVhbGNvbW0uY29tPgpSZXZpZXdlZC1ieTog
TWFyY28gTGllYmVsIDxtYXJjby5saWViZWxAb3NzLnF1YWxjb21tLmNvbT4KU2lnbmVkLW9mZi1i
eTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9o
ZXhhZ29uL2RlY29kZS5oICAgIHwgIDIgKysKIHRhcmdldC9oZXhhZ29uL2RlY29kZS5jICAgIHwg
MTkgKysrKysrKysrKysrKysrKysrKwogdGFyZ2V0L2hleGFnb24vcHJpbnRpbnNuLmMgfCAgMyAr
Ky0KIDMgZmlsZXMgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlm
ZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2RlY29kZS5oIGIvdGFyZ2V0L2hleGFnb24vZGVjb2Rl
LmgKaW5kZXggZDRiMDQ5OTYxZWQuLjFlMWUzMzliMDhhIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4
YWdvbi9kZWNvZGUuaAorKysgYi90YXJnZXQvaGV4YWdvbi9kZWNvZGUuaApAQCAtMzEsNSArMzEs
NyBAQCBpbnQgZGVjb2RlX3BhY2tldChEaXNhc0NvbnRleHQgKmN0eCwgaW50IG1heF93b3Jkcywg
Y29uc3QgdWludDMyX3QgKndvcmRzLAogICAgICAgICAgICAgICAgICAgUGFja2V0ICpwa3QsIGJv
b2wgZGlzYXNfb25seSk7CiAKIGJvb2wgb3Bjb2RlX3N1cHBvcnRlZCh1aW50MTZfdCBvcGNvZGUs
IGNvbnN0IEhleGFnb25DUFVEZWYgKmhleF9kZWYpOworYm9vbCBlbmNvZGluZ19zdXBwb3J0ZWQo
dWludDE2X3Qgb3Bjb2RlLCB1aW50MzJfdCBlbmNvZGluZywKKyAgICAgICAgICAgICAgICAgICAg
ICAgIGNvbnN0IEhleGFnb25DUFVEZWYgKmhleF9kZWYpOwogCiAjZW5kaWYKZGlmZiAtLWdpdCBh
L3RhcmdldC9oZXhhZ29uL2RlY29kZS5jIGIvdGFyZ2V0L2hleGFnb24vZGVjb2RlLmMKaW5kZXgg
YTI4YmY5Y2U5ZmUuLjM1ZDc0MWNlODY0IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9kZWNv
ZGUuYworKysgYi90YXJnZXQvaGV4YWdvbi9kZWNvZGUuYwpAQCAtNjkyLDYgKzY5MiwyMiBAQCBi
b29sIG9wY29kZV9zdXBwb3J0ZWQodWludDE2X3Qgb3Bjb2RlLCBjb25zdCBIZXhhZ29uQ1BVRGVm
ICpoZXhfZGVmKQogICAgIHJldHVybiB0cnVlOwogfQogCisvKgorICogU29tZSBlbmNvZGluZ3Mg
b2YgYW4gb3RoZXJ3aXNlIHN1cHBvcnRlZCBvcGNvZGUgYXJlIHJlc2VydmVkIG9uIG5ld2VyCisg
KiB2ZXJzaW9ucy4gIEhFWF9WRVJfQU5ZICh1c2VkIHdoZW4gb25seSBkaXNhc3NlbWJsaW5nKSBh
Y2NlcHRzIGV2ZXJ5dGhpbmcuCisgKi8KK2Jvb2wgZW5jb2Rpbmdfc3VwcG9ydGVkKHVpbnQxNl90
IG9wY29kZSwgdWludDMyX3QgZW5jb2RpbmcsCisgICAgICAgICAgICAgICAgICAgICAgICBjb25z
dCBIZXhhZ29uQ1BVRGVmICpoZXhfZGVmKQoreworICAgIC8qIEJpdCA3IG9mIEw0X2xvYWR3X3Bo
eXMgYmVjYW1lIHJlc2VydmVkIGluIHY4My4gKi8KKyAgICBpZiAoaGV4X2RlZi0+aGV4X3ZlcnNp
b24gIT0gSEVYX1ZFUl9BTlkgJiYKKyAgICAgICAgaGV4X2RlZi0+aGV4X3ZlcnNpb24gPj0gSEVY
X1ZFUl9WODMgJiYKKyAgICAgICAgb3Bjb2RlID09IEw0X2xvYWR3X3BoeXMgJiYgKGVuY29kaW5n
ICYgMHg4MCkpIHsKKyAgICAgICAgcmV0dXJuIGZhbHNlOworICAgIH0KKyAgICByZXR1cm4gdHJ1
ZTsKK30KKwogLyoKICAqIGRlY29kZV9wYWNrZXQKICAqIERlY29kZXMgcGFja2V0IHdpdGggZ2l2
ZW4gd29yZHMKQEAgLTcyMiw2ICs3MzgsOSBAQCBpbnQgZGVjb2RlX3BhY2tldChEaXNhc0NvbnRl
eHQgKmN0eCwgaW50IG1heF93b3JkcywgY29uc3QgdWludDMyX3QgKndvcmRzLAogICAgICAgICAg
ICAgLyogSW52YWxpZCBpbnN0cnVjdGlvbiBlbmNvZGluZyAqLwogICAgICAgICAgICAgcmV0dXJu
IDA7CiAgICAgICAgIH0KKyAgICAgICAgaWYgKCFlbmNvZGluZ19zdXBwb3J0ZWQoaW5zbi0+b3Bj
b2RlLCBlbmNvZGluZzMyLCBjdHgtPmhleF9kZWYpKSB7CisgICAgICAgICAgICByZXR1cm4gMDsK
KyAgICAgICAgfQogICAgICAgICAvKgogICAgICAgICAgKiBJZiB3ZSBzYXcgYW4gZXh0ZW5kZXIs
IG1hcmsgbmV4dCB3b3JkIGV4dGVuZGVkIHNvIGltbWVkaWF0ZQogICAgICAgICAgKiBkZWNvZGUg
d29ya3MKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL3ByaW50aW5zbi5jIGIvdGFyZ2V0L2hl
eGFnb24vcHJpbnRpbnNuLmMKaW5kZXggMDIzZWExMmRiYTUuLmNkYjlkY2Q3ZGU5IDEwMDY0NAot
LS0gYS90YXJnZXQvaGV4YWdvbi9wcmludGluc24uYworKysgYi90YXJnZXQvaGV4YWdvbi9wcmlu
dGluc24uYwpAQCAtMTcxLDcgKzE3MSw4IEBAIHZvaWQgc25wcmludF9hX3BrdF9kaXNhcyhHU3Ry
aW5nICpidWYsIFBhY2tldCAqcGt0LCB1aW50MzJfdCAqd29yZHMsCiAgICAgICAgIH0KIAogICAg
ICAgICBnX3N0cmluZ19hcHBlbmQoYnVmLCAiXHQiKTsKLSAgICAgICAgaWYgKG9wY29kZV9zdXBw
b3J0ZWQocGt0LT5pbnNuW2ldLm9wY29kZSwgY2ZnLT5oZXhfZGVmKSkgeworICAgICAgICBpZiAo
b3Bjb2RlX3N1cHBvcnRlZChwa3QtPmluc25baV0ub3Bjb2RlLCBjZmctPmhleF9kZWYpICYmCisg
ICAgICAgICAgICBlbmNvZGluZ19zdXBwb3J0ZWQocGt0LT5pbnNuW2ldLm9wY29kZSwgd29yZHNb
aV0sIGNmZy0+aGV4X2RlZikpIHsKICAgICAgICAgICAgIHNucHJpbnRpbnNuKGJ1ZiwgJihwa3Qt
Pmluc25baV0pKTsKICAgICAgICAgfSBlbHNlIHsKICAgICAgICAgICAgIGdfc3RyaW5nX2FwcGVu
ZChidWYsICI8aW52YWxpZD4iKTsKLS0gCjIuMzQuMQoK

