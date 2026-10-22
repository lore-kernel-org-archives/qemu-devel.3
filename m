Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1182606B7D9
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 18:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bHFwr1yp;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cYCQYzbH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJxac-0006E2-RP; Thu, 22 Oct 2026 14:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xJxa0-0006Az-4U
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 14:31:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xJxZy-0002ck-GR
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 14:31:55 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MHtmsI388899
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 18:31:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2hxDtN+wsubeZBUd54UCnU0Jho0DVSwQCsLM3NWAX+A=; b=bHFwr1ypWRpUDum5
 69XogSyvxJx0SMnqs0HeL0vI2wfED9veUX5P6pQThJnoOlmScLqNNdo5tvI5kdjH
 2ZqZ9RAk4g3xjFIMRf6b+Gwhc8GnuPaC/8dvO7WkEGCp/Medfo5n4lZ2GinPjswk
 EZ/WJQ7RTo4Ai4m1GGo+NQXBb4zmuR4X6qoz+MPjdD7tNJBQUEVKP5eTcqV4BSr5
 4aNKu05XkwEbXIANhNylxHP7YFtKyxGb+5RFN7ExU8p4D3bDnZ/USg/UniE99O2I
 gw5UCf68TzsYUOPepEcyrBAhiOWe72fh4lyNIE4MAbRn8yekeNvy+ocxKvnHkD4S
 Qouhiw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfewq42sf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 18:31:53 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3662e7a9299so401187eec.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 11:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792693912; x=1793298712; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2hxDtN+wsubeZBUd54UCnU0Jho0DVSwQCsLM3NWAX+A=;
 b=cYCQYzbH1kxit+gnzWAGxyTW1DK9WUSet9nU2pzMnPIpHqjfKkW6DC18Faki7NJZjn
 Euk14E1dC6kOQwHD0dOQ28UK/NEGGIpqNwge+Oz6jxwLKlD8nQytMruc1gesGCYnb+yB
 mcpLLZwu3nMAvqWWb9YyTWJnKatN6Dcl8oe/5OrQ0rcXuCKnpSJsJufWfx2+UtMW5h9P
 CT+DLXyk/6JFfFodQPtVyWBBqmvqLBsgWD/yf8O3oMsLHhvcoehvR7Y3iDtbA7msoC54
 AADx96hlJxmET7ZR1EspUdlrRZTKlrulAZUulpHE8vYcgCKNkfKbLephk81TvBp/67gP
 TX8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792693912; x=1793298712;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2hxDtN+wsubeZBUd54UCnU0Jho0DVSwQCsLM3NWAX+A=;
 b=tEJaoxcEvkusr7ooxVxlHy/wRv24Qq/SC8gp8QnwWMvCyM47xgGHWDhHMfwxTR6Vdj
 L2GajXs7M/giflfNqJQ6ioLjnRuKn0zVMLc25qToFTwVYPdsrv9CrMkmpqMcYLCAvWCl
 ikgvsQfCly0Vjm0UGM3JOnkJLuaL1xMMly5FaQLwo7Wy36XiroemM3MFnWQpiI0k76Po
 1ns+p9jZ9ItylScJ9pim++B+GEPfc/pXKkK0fOJTjlmKZ0Kg6+6dN17h2z+qg/w6XzHu
 niUYU4sV1fHCgzuOhJxk7j4n8xDvCpFDCevWxNzu8o7tlvUVlDHZsRy3xBR8bPIzsPZ4
 +f7g==
X-Gm-Message-State: AFq9FYL2S/L40opVve5iX2Czk43uqgc1nMEJKLajZ/i/zXqew78Wk8/l
 7LUE1ysdiRv5Q9KpPxQ9kshC094+f7GBzLgpLsP6bfiK3u54QHRMnU9iSes8OX9Fwf9kqAtaabq
 gyB+hUz1xh30u2JV3bKD2jkK1Y+uq9LxIf8dWkZnJAm2ZVG3QMyHk997OsW/u3tKO0w==
X-Gm-Gg: AYBFou3eh0/1uvAoAoszfs4GMxhz6sQCVw81xo34zCxvYAjRRTfntSswQ6rkylgMJoH
 cGSoWnmMwHa/cwmI9EJSC+kSL1BC1e8HYlNQJ3L/ihj2RZTGWRZwPrWoAldqXO4DVs4ZO4Hb8hD
 /Kw9niuitO+2OmAj687xHYQlrJ+DEB5ADOIBNPgmTOSTEuiK8IkscDxaEORGGClC4+AVyLqHQbe
 7LRs0Tv8dl9fZjelwBg8BNXn3L4ymPTtviVS9mtdOcxPYpDH+inWgKxZWJyaGXSZE7NBrnIhRep
 HFlmm3pn+GYy9oMTbFVi982TSTIXPbvgBfY+O35L4P9kpUMc7n1SLqBvRoQh+DwEck9LyM/vgtX
 84ZYVKtKDX5mfUuRIu7VE5WHz0NoVBgbAN41AIrMXVUJxg5C+
X-Received: by 2002:a05:7300:d090:b0:369:4c3f:8a5 with SMTP id
 5a478bee46e88-3694c3f09bfmr2782607eec.14.1792693911995; 
 Thu, 22 Oct 2026 11:31:51 -0700 (PDT)
X-Received: by 2002:a05:7300:d090:b0:369:4c3f:8a5 with SMTP id
 5a478bee46e88-3694c3f09bfmr2782569eec.14.1792693911405; 
 Thu, 22 Oct 2026 11:31:51 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369d8f8eaf9sm44962eec.16.2026.10.22.11.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 11:31:50 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Mohamed Mediouni <mohamed@unpredictable.fr>,
 Alessandro Di Federico <ale@rev.ng>, Laurent Vivier <laurent@vivier.eu>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH v4 01/11] target/hexagon: sort tag_rev_info entries by version
Date: Thu, 22 Oct 2026 11:31:37 -0700
Message-Id: <20261022183147.1535585-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261022183147.1535585-1-brian.cain@oss.qualcomm.com>
References: <20261022183147.1535585-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: KYsyJ20Xer7hBdKTE3kkC6TwyJLAdgLn
X-Proofpoint-ORIG-GUID: KYsyJ20Xer7hBdKTE3kkC6TwyJLAdgLn
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA3MyBTYWx0ZWRfX3lkpcHDnsVgu
 /F+C1RdOQTLoi+wI+SSBSJlK9f3bnaLTb1NacRWJiYz24i1kmc1TXQlHtNbw15cOmz7mTjSv7Nf
 pV310prN6VfcC4sCNVdXFWiGg31SwQ0=
X-Authority-Analysis: v=2.4 cv=G4OJgNk5 c=1 sm=1 tr=0 ts=6ada5699 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=XH382VzwAMdzo9DkozgA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA3MyBTYWx0ZWRfXw8fAP2r3gTAO
 WbqU3c/iWMZ0OjhuOKwzCP9AUQHEP0/hx/yKKc6u8Sq8ANsUPqsU05kYloatHEgg/N4KSFJZbGe
 HuTMGrMXY3ASUaZ/y+Meeh6AjROyDkcPVNTSn1Rse16xDNzTNNbczwIe1bavH5+MTbE7st3RZL6
 KTU1gXF1QsPwrJjdzKBqp21UjtJX3wkSjqEeFh6WTpQ8XhU6KLM8ndoK8vFmAiAeBl5MCsMXExu
 UC9yBxPAdAeF5ZlGLaiumlyark0ic57yFJnKNSsAQB4vkJsCiCFYv4E4OJN0qPgXsUI63PTmrOd
 wlACDaqf3r2zauG+7Y3xMHkMOU7boxKMcqVAr+7XzgvOJ32FYQ1ZwE62zda14sO3qbO3aTVGBMT
 ra8q0mytfZaiJr2+t8FgxAOQD/7HrTiKvOrJ6n2pcbx6EupJzgzS/MGjTK2Bfq4mDO4SAS3jwF7
 fSnUrMc3mZFMKNlTomw==
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

VGhlIFY3OSBRRmxvYXQgZW50cmllcyB3ZXJlIHBsYWNlZCBhZnRlciB0aGUgVjgxIGVudHJpZXMu
ICBNb3ZlIHRoZW0KYmVmb3JlIHRoZSBWODEgYmxvY2ssIGFuZCBncm91cCBWNl92Y29udl9iZl9x
ZjMyIHdpdGggdGhlIG90aGVyIFY4MQplbnRyaWVzLiAgTm8gZnVuY3Rpb25hbCBjaGFuZ2UuCgpS
ZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBvc3MucXVhbGNv
bW0uY29tPgpSZXZpZXdlZC1ieTogTWFyY28gTGllYmVsIDxtYXJjby5saWViZWxAb3NzLnF1YWxj
b21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNv
bW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL3RhZ19yZXZfaW5mby5jLmluYyB8IDMyICsrKysr
KysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25z
KCspLCAxNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi90YWdfcmV2
X2luZm8uYy5pbmMgYi90YXJnZXQvaGV4YWdvbi90YWdfcmV2X2luZm8uYy5pbmMKaW5kZXggNDFj
ZTNjYjU3MmYuLmIzODBhNmI0NGFlIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi90YWdfcmV2
X2luZm8uYy5pbmMKKysrIGIvdGFyZ2V0L2hleGFnb24vdGFnX3Jldl9pbmZvLmMuaW5jCkBAIC02
NDMsMjEgKzY0Myw2IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdGFnX3Jldl9pbmZvIHRhZ19yZXZf
aW5mb1tYWF9MQVNUX09QQ09ERV0gPSB7CiAgICAgW1kyX2RjZmV0Y2hib19udF0gPSB7IC5pbnRy
b2R1Y2VkID0gSEVYX1ZFUl9WNzksIC5yZW1vdmVkID0gSEVYX1ZFUl9OT05FIH0sCiAgICAgW1ky
X2RjemVyb2FfbnRdID0geyAuaW50cm9kdWNlZCA9IEhFWF9WRVJfVjc5LCAucmVtb3ZlZCA9IEhF
WF9WRVJfTk9ORSB9LAogCi0gICAgW1kyX3RsYnBwXSA9IHsgLmludHJvZHVjZWQgPSBIRVhfVkVS
X1Y4MSwgLnJlbW92ZWQgPSBIRVhfVkVSX05PTkUgfSwKLQotICAgIFtWNl92YWxpZ240XSA9IHsg
LmludHJvZHVjZWQgPSBIRVhfVkVSX1Y4MSwgLnJlbW92ZWQgPSBIRVhfVkVSX05PTkUgfSwKLSAg
ICBbVjZfdmVxaGZdID0geyAuaW50cm9kdWNlZCA9IEhFWF9WRVJfVjgxLCAucmVtb3ZlZCA9IEhF
WF9WRVJfTk9ORSB9LAotICAgIFtWNl92ZXFoZl9hbmRdID0geyAuaW50cm9kdWNlZCA9IEhFWF9W
RVJfVjgxLCAucmVtb3ZlZCA9IEhFWF9WRVJfTk9ORSB9LAotICAgIFtWNl92ZXFoZl9vcl0gPSB7
IC5pbnRyb2R1Y2VkID0gSEVYX1ZFUl9WODEsIC5yZW1vdmVkID0gSEVYX1ZFUl9OT05FIH0sCi0g
ICAgW1Y2X3ZlcWhmX3hvcl0gPSB7IC5pbnRyb2R1Y2VkID0gSEVYX1ZFUl9WODEsIC5yZW1vdmVk
ID0gSEVYX1ZFUl9OT05FIH0sCi0gICAgW1Y2X3ZlcXNmXSA9IHsgLmludHJvZHVjZWQgPSBIRVhf
VkVSX1Y4MSwgLnJlbW92ZWQgPSBIRVhfVkVSX05PTkUgfSwKLSAgICBbVjZfdmVxc2ZfYW5kXSA9
IHsgLmludHJvZHVjZWQgPSBIRVhfVkVSX1Y4MSwgLnJlbW92ZWQgPSBIRVhfVkVSX05PTkUgfSwK
LSAgICBbVjZfdmVxc2Zfb3JdID0geyAuaW50cm9kdWNlZCA9IEhFWF9WRVJfVjgxLCAucmVtb3Zl
ZCA9IEhFWF9WRVJfTk9ORSB9LAotICAgIFtWNl92ZXFzZl94b3JdID0geyAuaW50cm9kdWNlZCA9
IEhFWF9WRVJfVjgxLCAucmVtb3ZlZCA9IEhFWF9WRVJfTk9ORSB9LAotICAgIFtWNl92Y29udl9o
X2hmX3JuZF0gPSB7Ci0gICAgICAgIC5pbnRyb2R1Y2VkID0gSEVYX1ZFUl9WODEsIC5yZW1vdmVk
ID0gSEVYX1ZFUl9OT05FCi0gICAgfSwKLQogICAgIFtWNl9nZXRfcWZleHRdID0geyAuaW50cm9k
dWNlZCA9IEhFWF9WRVJfVjc5LCAucmVtb3ZlZCA9IEhFWF9WRVJfTk9ORSB9LAogICAgIFtWNl9n
ZXRfcWZleHRfb3JhY2NdID0gewogICAgICAgICAuaW50cm9kdWNlZCA9IEhFWF9WRVJfVjc5LCAu
cmVtb3ZlZCA9IEhFWF9WRVJfTk9ORQpAQCAtNjcxLDcgKzY1Niw2IEBAIHN0YXRpYyBjb25zdCBz
dHJ1Y3QgdGFnX3Jldl9pbmZvIHRhZ19yZXZfaW5mb1tYWF9MQVNUX09QQ09ERV0gPSB7CiAgICAg
ICAgIC5pbnRyb2R1Y2VkID0gSEVYX1ZFUl9WNzksIC5yZW1vdmVkID0gSEVYX1ZFUl9OT05FCiAg
ICAgfSwKICAgICBbVjZfdmFic19xZjMyX3NmXSA9IHsgLmludHJvZHVjZWQgPSBIRVhfVkVSX1Y3
OSwgLnJlbW92ZWQgPSBIRVhfVkVSX05PTkUgfSwKLSAgICBbVjZfdmNvbnZfYmZfcWYzMl0gPSB7
IC5pbnRyb2R1Y2VkID0gSEVYX1ZFUl9WODEsIC5yZW1vdmVkID0gSEVYX1ZFUl9OT05FIH0sCiAg
ICAgW1Y2X3Zjb252X3FmMTZfaGZdID0geyAuaW50cm9kdWNlZCA9IEhFWF9WRVJfVjc5LCAucmVt
b3ZlZCA9IEhFWF9WRVJfTk9ORSB9LAogICAgIFtWNl92Y29udl9xZjE2X3FmMTZdID0gewogICAg
ICAgICAuaW50cm9kdWNlZCA9IEhFWF9WRVJfVjc5LCAucmVtb3ZlZCA9IEhFWF9WRVJfTk9ORQpA
QCAtNjk4LDYgKzY4MiwyMiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHRhZ19yZXZfaW5mbyB0YWdf
cmV2X2luZm9bWFhfTEFTVF9PUENPREVdID0gewogICAgIFtWNl92bmVnX3FmMzJfc2ZdID0geyAu
aW50cm9kdWNlZCA9IEhFWF9WRVJfVjc5LCAucmVtb3ZlZCA9IEhFWF9WRVJfTk9ORSB9LAogICAg
IFtWNl92c3ViX2hmX21peF0gPSB7IC5pbnRyb2R1Y2VkID0gSEVYX1ZFUl9WNzksIC5yZW1vdmVk
ID0gSEVYX1ZFUl9OT05FIH0sCiAgICAgW1Y2X3ZzdWJfc2ZfbWl4XSA9IHsgLmludHJvZHVjZWQg
PSBIRVhfVkVSX1Y3OSwgLnJlbW92ZWQgPSBIRVhfVkVSX05PTkUgfSwKKworICAgIFtZMl90bGJw
cF0gPSB7IC5pbnRyb2R1Y2VkID0gSEVYX1ZFUl9WODEsIC5yZW1vdmVkID0gSEVYX1ZFUl9OT05F
IH0sCisKKyAgICBbVjZfdmFsaWduNF0gPSB7IC5pbnRyb2R1Y2VkID0gSEVYX1ZFUl9WODEsIC5y
ZW1vdmVkID0gSEVYX1ZFUl9OT05FIH0sCisgICAgW1Y2X3ZlcWhmXSA9IHsgLmludHJvZHVjZWQg
PSBIRVhfVkVSX1Y4MSwgLnJlbW92ZWQgPSBIRVhfVkVSX05PTkUgfSwKKyAgICBbVjZfdmVxaGZf
YW5kXSA9IHsgLmludHJvZHVjZWQgPSBIRVhfVkVSX1Y4MSwgLnJlbW92ZWQgPSBIRVhfVkVSX05P
TkUgfSwKKyAgICBbVjZfdmVxaGZfb3JdID0geyAuaW50cm9kdWNlZCA9IEhFWF9WRVJfVjgxLCAu
cmVtb3ZlZCA9IEhFWF9WRVJfTk9ORSB9LAorICAgIFtWNl92ZXFoZl94b3JdID0geyAuaW50cm9k
dWNlZCA9IEhFWF9WRVJfVjgxLCAucmVtb3ZlZCA9IEhFWF9WRVJfTk9ORSB9LAorICAgIFtWNl92
ZXFzZl0gPSB7IC5pbnRyb2R1Y2VkID0gSEVYX1ZFUl9WODEsIC5yZW1vdmVkID0gSEVYX1ZFUl9O
T05FIH0sCisgICAgW1Y2X3ZlcXNmX2FuZF0gPSB7IC5pbnRyb2R1Y2VkID0gSEVYX1ZFUl9WODEs
IC5yZW1vdmVkID0gSEVYX1ZFUl9OT05FIH0sCisgICAgW1Y2X3ZlcXNmX29yXSA9IHsgLmludHJv
ZHVjZWQgPSBIRVhfVkVSX1Y4MSwgLnJlbW92ZWQgPSBIRVhfVkVSX05PTkUgfSwKKyAgICBbVjZf
dmVxc2ZfeG9yXSA9IHsgLmludHJvZHVjZWQgPSBIRVhfVkVSX1Y4MSwgLnJlbW92ZWQgPSBIRVhf
VkVSX05PTkUgfSwKKyAgICBbVjZfdmNvbnZfaF9oZl9ybmRdID0geworICAgICAgICAuaW50cm9k
dWNlZCA9IEhFWF9WRVJfVjgxLCAucmVtb3ZlZCA9IEhFWF9WRVJfTk9ORQorICAgIH0sCisgICAg
W1Y2X3Zjb252X2JmX3FmMzJdID0geyAuaW50cm9kdWNlZCA9IEhFWF9WRVJfVjgxLCAucmVtb3Zl
ZCA9IEhFWF9WRVJfTk9ORSB9LAogfTsKIAogI2VuZGlmIC8qIEhFWEFHT05fVEFHX0FSQ0hfVEFC
TEVfSCAqLwotLSAKMi4zNC4xCgo=

