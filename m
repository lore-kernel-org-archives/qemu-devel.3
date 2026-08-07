Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2EF0C5AC7A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 15:24:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsMPN-0000jG-5o; Fri, 07 Aug 2026 11:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wsMPK-0000iG-1M
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 11:22:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wsMPG-0006ho-W9
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 11:22:49 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 677CgGFC942909
 for <qemu-devel@nongnu.org>; Fri, 7 Aug 2026 15:22:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=7v7Z+jUrMyLbMvr/H3tEiPNRxqOAGx/XOr1xzx4/+xU=; b=js
 L5MoOrkcX0i+yirj98CmUyFjP5FS1+X3pGsEfvppuApNPwPqFDz0ESu/zPkqK6gt
 hsF3JnqoKoHKEKPJNpAZVt4lPo0DWwRxRtlcdmfDKCKja9QJ4ou31uOrco+5jR9r
 /v8WF5sKENtG6Lgb6qOUa7rUYSQmOznmVCUXYnGrrlu9tibuDqi2ev9mHzfIlL5Y
 RUg6WF3oBTadKdMSOUEhh3mq+vDvKIu3GOE0ZFupxfG9UtE9/EpByZBb7lA5sBpQ
 +uyZVFlgddx3o+WscEGBd8ehJks8C4n3EUnlAxo/PGMzgToz9z/fV739rTkduVrN
 IVRAGlYRJ31E4r6GMAfA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6hcm9f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 15:22:45 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cb835525b13so4141263a12.1
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 08:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786116164; x=1786720964; darn=nongnu.org;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=7v7Z+jUrMyLbMvr/H3tEiPNRxqOAGx/XOr1xzx4/+xU=;
 b=WbWOYk58pjQRdSUcEb+5Ic3A1gINX+461GA0thVuKqMu+ZWgnZAEL0qRPJq5mKTYA4
 R1FKYqMOOS7ko38qe1z3MxdB8bI3B3x0dScQv1VC95gG/nSXACdDfduCpXV96aQeTas9
 b6zwEDPtnC0F70UwEvBJv/ia4wemVp9k8JThFDyAQYcFYmdOc36mZza8aiEBJ3K2tfCa
 4jdzjdLXFsjAP0mojq4lNXK+ca5DrjxulbzWAko1ODnzL6oGFy/O+lGDesyWFlTgzPrI
 AzXKSaJCQEEm9p5DRnYcL7CTQvxLhd9OiuXqSzKKvObpDT7RrOsbwQwulEKH3QCz4qXr
 SQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786116164; x=1786720964;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7v7Z+jUrMyLbMvr/H3tEiPNRxqOAGx/XOr1xzx4/+xU=;
 b=mi7b6XmVZlfXmBOkhrLOPLFoBvNblIyuCpItOdjtxDmMeVTZv9xif51809sLknaxWm
 Dt85OGR8HYvZnPkSaVVRrIHDtKoHGTQw32DZsKJVKmrROrTHfiOlitOAG2GjWH4sLRgt
 1aUlesiILfcNRnReCXNqNoWODLmmDI7kyvo3JkNCajl43OWi3j8fFurWbL8CXMlMVhJ7
 z5mV9ao5KfGqAdOqb1uaKSx7IQtdfwasjdUGPDPwVE1v+SiZdhDw/fIhGDdRuDL8ZXGc
 iEeyIG4tZoebm0YnqRiQhVquGky8/siSq7+8VZUIuO09lKC7LEQyeRITqr9fuaso4mMz
 oZLQ==
X-Gm-Message-State: AOJu0Yw/CEQGCFaCoJFr4eZPN26QeeF/L2Pgk1a5HrDRPAm+TE10MEj9
 6lsBy/ckWni10y8PIN4h2D24IXM6k01p+Hd3soWUDHk+AMzc0s2nqcLxjx047RT8d9Iu8t4jcJG
 e2raZC65ZsAU7H73TZDturtjJ19LXlw/ssTFEgL8OCh+7J51tV4YIv8CMq3f2LclTcw==
X-Gm-Gg: AR+sD12I0mVaozWor2MB+uM7+XgLfUM7PA2KoneHt5n3/mGeNivhdRqNwQ90F9Ob/tE
 p8NEAE+fChXrvNgd0U/CUdKvqfwxywqh0ZbCNd5Q3wOWm/WyirE/rQh6tbLzEGLcZ8WmQAqkoi6
 4AJBKGJW6uTbZwO6zNKSJqvDCxq6/QAmWZuh4FHA6343+8GkgCamsRg0aVGNVGEYFwSgE6ki3IV
 Jiaot7rUSQ6KGSCTry0SBai9ikCyYXO3OrM7/VjoUmhyiBPY9eUQiwsppyv9MHIYX9mHlGGAjXr
 FIXg7SFm5VxSLjsCTBZFoP1vdMChXGLRgI/swXB2K0aTbaLQ7gi9JdVY/PznFKj6UIBTsWAAdiE
 cL5fTc+NQbt4SLAuttycZQI1h+Db+Wk9Yxkv/i7vexNyaSWEc
X-Received: by 2002:a05:6a20:1602:b0:3c3:a3f4:5485 with SMTP id
 adf61e73a8af0-3cbce6cb2dbmr1580185637.6.1786116164508; 
 Fri, 07 Aug 2026 08:22:44 -0700 (PDT)
X-Received: by 2002:a05:6a20:1602:b0:3c3:a3f4:5485 with SMTP id
 adf61e73a8af0-3cbce6cb2dbmr1580130637.6.1786116164033; 
 Fri, 07 Aug 2026 08:22:44 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315beb883d9sm8604756eec.15.2026.08.07.08.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 08:22:43 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-stable@nongnu.org
Subject: [PATCH v3 1/7] host-utils: fix ssub32/64_saturate return type and
 clamp direction
Date: Fri,  7 Aug 2026 08:22:35 -0700
Message-Id: <20260807152241.1576334-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260807152241.1576334-1-brian.cain@oss.qualcomm.com>
References: <20260807152241.1576334-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: -FQyugtuk0SJWa8m2UpybMhXQwlNAavb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDExOSBTYWx0ZWRfX41HzZul/6jNS
 huqSQu9iOWb3AIr681Q5vapws2Mibm/AKyPqSu34aXOrmQL1rbUR3+A49P+UkF9PD5xo+dsG+fv
 ygW00g9W7HSLZimuayRcoONdWTegmkv80WaVdeTJyYeVmQd3tcUAf0qNKPX4F6SefmBmp4kh/dm
 R7YotBgP0TPxUQjL2wjZSPqa6hDTMyOAdDFKzfOJgkVlGn7AoLu34y8BzCYgvoq/8XQ6RM9Leb7
 0I1rvQxz7BD9z6Ujp4mixabKy55Ud0D/rXPvt/nR7QxnVWBPBml7/xltk5WzrjeLJ0+mBOMhpMV
 gWOwPVTcLtJDTW2B86Kc5/iHmZdEziZHAdc0NGnwlOhV2AJQLaEZt+/ZIv6wt7tTn79rtnQJM4u
 JmKtozSkOwj0vUXOZ/5KbP1/g6+Sy7yRwbahGreuRg286pqedcG0Ip5jALwJ/2S1MVcQQON9ZRw
 q/RhOgcfCxbm3ytUitw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDExOSBTYWx0ZWRfX5mN7skCU2BkU
 2z1WP6Wp2e7Ih0wyiVv/OE2qxHG46tFcWOWqASApRWjet4FMflzrCyrhDO+3RPKOUjze3f75GNm
 2WlvoDrtFRi3NO4CGEAXNMwnvhOOxD4=
X-Proofpoint-ORIG-GUID: -FQyugtuk0SJWa8m2UpybMhXQwlNAavb
X-Authority-Analysis: v=2.4 cv=MbpcfZ/f c=1 sm=1 tr=0 ts=6a75f845 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=69wJf7TsAAAA:8 a=kM50MvNqywxRmdRKJWUA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070119
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

c3N1YjMyX3NhdHVyYXRlKCkgYW5kIHNzdWI2NF9zYXR1cmF0ZSgpIHdlcmUgZGVjbGFyZWQgdG8g
cmV0dXJuIGJvb2wKaW5zdGVhZCBvZiBpbnQzMl90L2ludDY0X3QsIGFuZCBjbGFtcGVkIHRvIHRo
ZSB3cm9uZyBib3VuZCBvbiBvdmVyZmxvdy4KClJldmlld2VkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1
LURhdWTDqSA8cGhpbG1kQG9zcy5xdWFsY29tbS5jb20+CkNjOiBxZW11LXN0YWJsZUBub25nbnUu
b3JnCkZpeGVzOiAxNjQ5NTUzMzEzMSAoImhvc3QtdXRpbHM6IEludHJvZHVjZSBzaWduZWQgc2F0
dXJhdGlvbiBwcmltaXRpdmVzIikKUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJy
aWNrLmJvdXZpZXJAb3NzLnF1YWxjb21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8
YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIGluY2x1ZGUvcWVtdS9ob3N0LXV0aWxz
LmggfCAyNCArKysrKysrKysrKystLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNl
cnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL3FlbXUvaG9z
dC11dGlscy5oIGIvaW5jbHVkZS9xZW11L2hvc3QtdXRpbHMuaAppbmRleCAyZThkYTdmYjNkMC4u
MWRiOWRiYjEzOGUgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvcWVtdS9ob3N0LXV0aWxzLmgKKysrIGIv
aW5jbHVkZS9xZW11L2hvc3QtdXRpbHMuaApAQCAtNjA3LDEwICs2MDcsMTAgQEAgc3RhdGljIGlu
bGluZSBib29sIHVtdWw2NF9vdmVyZmxvdyh1aW50NjRfdCB4LCB1aW50NjRfdCB5LCB1aW50NjRf
dCAqcmV0KQogfQogCiAvKioKLSAqIHNhZGQzMl9zYXR1cmF0ZSAtIGFkZGl0aW9uIHdpdGggc2F0
dXJhdGlvbgorICogc2FkZDMyX3NhdHVyYXRlIC0gMzItYml0IHNpZ25lZCBhZGRpdGlvbiB3aXRo
IHNhdHVyYXRpb24KICAqIEB4LCBAeTogYWRkZW5kcwogICoKLSAqIENvbXB1dGVzIEB4ICsgQHks
IGFuZCBzYXR1cmF0ZXMgcmF0aGVybiB0aGFuIHRydW5jYXRpbmcgdGhlIHJlc3VsdC4KKyAqIENv
bXB1dGVzIEB4ICsgQHksIGFuZCBzYXR1cmF0ZXMgcmF0aGVyIHRoYW4gdHJ1bmNhdGluZyB0aGUg
cmVzdWx0LgogICovCiBzdGF0aWMgaW5saW5lIGludDMyX3Qgc2FkZDMyX3NhdHVyYXRlKGludDMy
X3QgeCwgaW50MzJfdCB5KQogewpAQCAtNjIyLDEwICs2MjIsMTAgQEAgc3RhdGljIGlubGluZSBp
bnQzMl90IHNhZGQzMl9zYXR1cmF0ZShpbnQzMl90IHgsIGludDMyX3QgeSkKIH0KIAogLyoqCi0g
KiBzYWRkNjRfc2F0dXJhdGUgLSBhZGRpdGlvbiB3aXRoIHNhdHVyYXRpb24KKyAqIHNhZGQ2NF9z
YXR1cmF0ZSAtIDY0LWJpdCBzaWduZWQgYWRkaXRpb24gd2l0aCBzYXR1cmF0aW9uCiAgKiBAeCwg
QHk6IGFkZGVuZHMKICAqCi0gKiBDb21wdXRlcyBAeCArIEB5LCBhbmQgc2F0dXJhdGVzIHJhdGhl
cm4gdGhhbiB0cnVuY2F0aW5nIHRoZSByZXN1bHQuCisgKiBDb21wdXRlcyBAeCArIEB5LCBhbmQg
c2F0dXJhdGVzIHJhdGhlciB0aGFuIHRydW5jYXRpbmcgdGhlIHJlc3VsdC4KICAqLwogc3RhdGlj
IGlubGluZSBpbnQ2NF90IHNhZGQ2NF9zYXR1cmF0ZShpbnQ2NF90IHgsIGludDY0X3QgeSkKIHsK
QEAgLTYzNywzMSArNjM3LDMxIEBAIHN0YXRpYyBpbmxpbmUgaW50NjRfdCBzYWRkNjRfc2F0dXJh
dGUoaW50NjRfdCB4LCBpbnQ2NF90IHkpCiB9CiAKIC8qKgotICogc3N1YjMyX3NhdHVyYXRlIC0g
c3VidHJhY3Rpb24gd2l0aCBzYXR1cmF0aW9uCisgKiBzc3ViMzJfc2F0dXJhdGUgLSAzMi1iaXQg
c2lnbmVkIHN1YnRyYWN0aW9uIHdpdGggc2F0dXJhdGlvbgogICogQHgsIEB5OiBhZGRlbmRzCiAg
KgotICogQ29tcHV0ZXMgQHggKyBAeSwgYW5kIHNhdHVyYXRlcyByYXRoZXJuIHRoYW4gdHJ1bmNh
dGluZyB0aGUgcmVzdWx0LgorICogQ29tcHV0ZXMgQHggLSBAeSwgYW5kIHNhdHVyYXRlcyByYXRo
ZXIgdGhhbiB0cnVuY2F0aW5nIHRoZSByZXN1bHQuCiAgKi8KLXN0YXRpYyBpbmxpbmUgYm9vbCBz
c3ViMzJfc2F0dXJhdGUoaW50MzJfdCB4LCBpbnQzMl90IHkpCitzdGF0aWMgaW5saW5lIGludDMy
X3Qgc3N1YjMyX3NhdHVyYXRlKGludDMyX3QgeCwgaW50MzJfdCB5KQogewogICAgIGludDMyX3Qg
cmV0OwogICAgIGlmIChzc3ViMzJfb3ZlcmZsb3coeCwgeSwgJnJldCkpIHsKLSAgICAgICAgcmV0
ID0geCA8IDAgPyBJTlQzMl9NQVggOiBJTlQzMl9NSU47CisgICAgICAgIHJldCA9IHggPCAwID8g
SU5UMzJfTUlOIDogSU5UMzJfTUFYOwogICAgIH0KICAgICByZXR1cm4gcmV0OwogfQogCiAvKioK
LSAqIHNzdWI2NF9zYXR1cmF0ZSAtIHN1YnRyYWN0aW9uIHdpdGggc2F0dXJhdGlvbgorICogc3N1
YjY0X3NhdHVyYXRlIC0gNjQtYml0IHNpZ25lZCBzdWJ0cmFjdGlvbiB3aXRoIHNhdHVyYXRpb24K
ICAqIEB4LCBAeTogYWRkZW5kcwogICoKLSAqIENvbXB1dGVzIEB4ICsgQHksIGFuZCBzYXR1cmF0
ZXMgcmF0aGVybiB0aGFuIHRydW5jYXRpbmcgdGhlIHJlc3VsdC4KKyAqIENvbXB1dGVzIEB4IC0g
QHksIGFuZCBzYXR1cmF0ZXMgcmF0aGVyIHRoYW4gdHJ1bmNhdGluZyB0aGUgcmVzdWx0LgogICov
Ci1zdGF0aWMgaW5saW5lIGJvb2wgc3N1YjY0X3NhdHVyYXRlKGludDY0X3QgeCwgaW50NjRfdCB5
KQorc3RhdGljIGlubGluZSBpbnQ2NF90IHNzdWI2NF9zYXR1cmF0ZShpbnQ2NF90IHgsIGludDY0
X3QgeSkKIHsKICAgICBpbnQ2NF90IHJldDsKICAgICBpZiAoc3N1YjY0X292ZXJmbG93KHgsIHks
ICZyZXQpKSB7Ci0gICAgICAgIHJldCA9IHggPCAwID8gSU5UNjRfTUFYIDogSU5UNjRfTUlOOwor
ICAgICAgICByZXQgPSB4IDwgMCA/IElOVDY0X01JTiA6IElOVDY0X01BWDsKICAgICB9CiAgICAg
cmV0dXJuIHJldDsKIH0KLS0gCjIuMzQuMQoK

