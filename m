Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254D7606A322
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 02:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=b41mg2zE;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PsUCysva
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK4v4-0006SG-OZ; Thu, 22 Oct 2026 22:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK4uo-0006R8-QJ
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 22:21:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK4um-0000ti-55
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 22:21:54 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69N1FR8N991288
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 02:21:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 abQJXyQkFkPhBZRMFmNAAdfabiQcR+uwKzQgUnZT9wE=; b=b41mg2zE9mWXJML3
 2YRaP8hIuhWpabAz0UMcjweRjwLnmQVChun3M/b7dSHD/sEEuJ/aQRH+k58+skAA
 29u84heff1ZtzmPfYKRuwJC9YrtoZKctr0SR3VaChm93T0LdSh833uTDGi4ZfULe
 d0wywkj8pqVQ9EFbWKotqYWR2H9/9yBhex6ablCbFXsndIfeytADrzbuy+SWhxcx
 58MO4/E5aAr7KFTKyVDMF1EwvjghlTXfBW75lsU1DqYYRNhsX7SBb0qyi3hJf0ne
 jjvO4pQWhw16B4/xb13zooRu4+XQ5esdSVw4yMpLdkGFBvDKM1R29QmHzL+sOMYG
 f/ojdQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfpahsvsm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 02:21:49 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-359b81ad4e8so574456eec.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 19:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792722109; x=1793326909; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=abQJXyQkFkPhBZRMFmNAAdfabiQcR+uwKzQgUnZT9wE=;
 b=PsUCysvawqMQtacLUIMMyxzqzTTaI1agwxZ8VqLfnihKJs473H+wjKFmtTplWXdfpN
 eTeAO5PO8QuNGIkDc/awsnZl/5UHhTtEqjzmEUgoj2VSerlhaZwmqFJhcX2Scyd8LW9D
 Jksssoisk7uJxwAqdzhZJZaSWhxGE5f1vnLh0pE85pijsp8HWmkWEGATu/Yyw7GdujDU
 WW7pnnl0isGZCFY2pSkwp0Jgs+DfIgvcb7R+/k9E+mVT0iTctnqwwvqx6Op3NPyFGf6r
 xfVGYUp3rIMKi6DqJXK2x59cAHa1LX6b66ez0Wq8G9gsaW913KDCQpUml6DJL8bgWiDO
 2tzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792722109; x=1793326909;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=abQJXyQkFkPhBZRMFmNAAdfabiQcR+uwKzQgUnZT9wE=;
 b=Q4qNp2aQn6c88y2X0JV1r/h8OWk8xCTTrrzGn4HIZ3PoCUm2+LgklNAoAtWsIQqbn1
 VtW91SmbE9HraHByDcvnyMv9CBpXeUl9aC7BbRCqr87rYnhY7mJHt+LvDDjh2ixnq0r+
 T0qYupIkx6v5SO4zrZwtQgvpk3ShiaxXbhgstaW12BnUKf9c4bp8aOIG8TB8SD3BQ0v/
 W7BG7bM7YBxxOfC+5xIDyt7PHPtLQigTIEdnsCbPw2OeeSgOK1NWmrZEBe7nh9IluIog
 MD67lqyoVY+i84gqtC9boTyQEHUOg3FiSYCdlViJ+cscuj0BJq1ErWH9SOf+twRs8ep2
 sAQA==
X-Gm-Message-State: AFq9FYIzvos0/jJI5JMA4C35EOsNcKpEIjZVbbu2oK9bYkg+9uZ6iEQb
 yTKmScJMZoHNGhmaN5MpPnoEZpxNjtGhBl42e1REmgQAlQsUpFbv3a+dQj3Hchc7WGEwgoKxCDV
 IoX8E4a37LvkHGWL41l+xE+iZ9mrs6PfI2MbJgzk/yiNw0adUIOmSlyIpx85C0N3Puw==
X-Gm-Gg: AYBFou2+B8FLKWmgP28hxN1E7l9w+lBF8Ly0KTkc0+lSz94valIlDB+dUfnSVwYwOjV
 X3NuuH5iCg5xNVkhhGrfdb2M8ZZwjLxae34iSnZJYeE6Iun4QgwjM3gonVMV4RBAo1QT4q4f8VS
 eMS1TKrpv+BwRvKIube3zLOAXlbV88HNK3jZ7yD/lQenJ8fZqx2UYj5rWE9fkueygHssAqRE1Zp
 /n16eNdpfQIOyzjGx1xKoVVb0v5v4q5H3FAtHKamr0Mva2tKa61StZVDAbreMU6MccnOdjWLru+
 Fw8yR7/zInjoeJEGg3N8vIZGwJuaZGxCk2ySOX85DQ3gAjbXQpWTO0z3xLqMYPlU2lFAy3MLkTP
 1t1l9+ufCqDNryF03THRq6IVt/S35gsW3aG9Qyb6yw9fEORjN
X-Received: by 2002:a05:701b:4194:20b0:189:d6bf:7eaa with SMTP id
 a92af1059eb24-195c4d61629mr1273087c88.16.1792722108768; 
 Thu, 22 Oct 2026 19:21:48 -0700 (PDT)
X-Received: by 2002:a05:701b:4194:20b0:189:d6bf:7eaa with SMTP id
 a92af1059eb24-195c4d61629mr1273063c88.16.1792722108171; 
 Thu, 22 Oct 2026 19:21:48 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-195eae0e918sm2093713c88.11.2026.10.22.19.21.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 19:21:47 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 40/43] target/hexagon: use get_user*() for semihosting arguments
Date: Thu, 22 Oct 2026 18:50:37 -0700
Message-Id: <20261023015040.2473105-41-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023015040.2473105-1-brian.cain@oss.qualcomm.com>
References: <20261023015040.2473105-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAwOSBTYWx0ZWRfXzLtlVLtQzKQ/
 g/AMocw1MiiUHbB5WJxwYnAUlkHD/L5wQraiL656n0NcJQOsdQ/amEXEwB2xWs7HCj0j97NpqYM
 2n2K/RZJH7yK2+XrKohoaFyszgWj3Ag=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAwOSBTYWx0ZWRfX8Nd5TqP84NUG
 CrF2d0x0FJdRdSn681LF8nqaX2jMe/f/GE9TTaFLbmbJbYrUbzFy8Izl9yQSXRamNwUks02pR/A
 EgM2RVH64y+1scnH+HUkcGflhA9ZnbS+o1ZJQDjp56W2Sa3KK67Py2jLHjE9wae7roMx1BvyEpJ
 MuW9bNJL2GOwRhkZCOBVjFKpX/LGS0WPDG4u1x6LjRA6WXoIHkHt5RrxLMmb9XcJhhB2a+Z5D4/
 yic8wPoTGTt3dB2QrGqguQ98/bssWZ+1iuZsqafDaETOwnfDSbL2AZmXA8weLvPl8oop5TBzYGc
 Tgc/LC0AbR7VOI9Y6wnM4HAsSDsjcXgmhqhss7uAjibq1IEqpt4otyroU3F1RGD3pD0ooekBjec
 RZUGjkenT7eqpdFwg75yI1ceFHlJRD5lX+8ePakA/wCQMACBGja7HN0xgE0/9yqqtQ5D5LUA25L
 /x0JRBDUKfplPWa+D8A==
X-Proofpoint-GUID: 0Nu5o_poXbQwCElRGBOzuupDGR_Sa7tB
X-Authority-Analysis: v=2.4 cv=YIMKWhGx c=1 sm=1 tr=0 ts=6adac4be cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=S4j5GwEIB_8BIiuHkXUA:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 0Nu5o_poXbQwCElRGBOzuupDGR_Sa7tB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230009
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

TGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC9DQUZFQWNBOUVMMTB4cFB4
XzBZRC1xNlljV1dQOS1pd2N5Rzh4MHMxeVFoS0ItWFFHWFFAbWFpbC5nbWFpbC5jb20vClN1Z2dl
c3RlZC1ieTogUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPgpSZXZpZXdl
ZC1ieTogUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPgpTaWduZWQtb2Zm
LWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0
L2hleGFnb24vaGV4c3dpLmMgfCA2NyArKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0t
LS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDM3IGluc2VydGlvbnMoKyksIDMwIGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2hleHN3aS5jIGIvdGFyZ2V0L2hleGFnb24v
aGV4c3dpLmMKaW5kZXggYmIxM2VmNWU1MjMuLjg0Yzc3NDA5MWI1IDEwMDY0NAotLS0gYS90YXJn
ZXQvaGV4YWdvbi9oZXhzd2kuYworKysgYi90YXJnZXQvaGV4YWdvbi9oZXhzd2kuYwpAQCAtNDcz
LDI5ICs0NzMsMzUgQEAgc3RhdGljIHZvaWQgc2ltX2hhbmRsZV90cmFwMChDUFVIZXhhZ29uU3Rh
dGUgKmVudikKIAogICAgIGNhc2UgSEVYX1NZU19PUEVOOgogICAgIHsKLSAgICAgICAgY2hhciAq
ZmlsZW5hbWU7CisgICAgICAgIGNoYXIgZmlsZW5hbWVbQlVGU0laXTsKICAgICAgICAgdGFyZ2V0
X3Vsb25nIHBoeXNpY2FsX2ZpbGVuYW1lX2FkZHI7CiAgICAgICAgIHVuc2lnbmVkIGludCBmaWxl
bW9kZTsKLSAgICAgICAgdWludDMyX3QgZmlsZW5hbWVfbGVuOwotICAgICAgICBzaXplX3QgZmls
ZW5hbWVfc2l6ZTsKKyAgICAgICAgdWludDMyX3QgbGVuZ3RoOwogICAgICAgICBpbnQgcmVhbF9v
cGVubW9kZTsKICAgICAgICAgaW50IHJldCwgZXJyID0gMDsKKyAgICAgICAgaW50IGkgPSAwOwog
CiAgICAgICAgIGlmIChnZXRfdXNlcl91MzIocGh5c2ljYWxfZmlsZW5hbWVfYWRkciwgc3dpX2lu
Zm8pIHx8CiAgICAgICAgICAgICBnZXRfdXNlcl91MzIoZmlsZW1vZGUsIHN3aV9pbmZvICsgNCkg
fHwKLSAgICAgICAgICAgIGdldF91c2VyX3UzMihmaWxlbmFtZV9sZW4sIHN3aV9pbmZvICsgOCkp
IHsKKyAgICAgICAgICAgIGdldF91c2VyX3UzMihsZW5ndGgsIHN3aV9pbmZvICsgOCkpIHsKICAg
ICAgICAgICAgIGdvdG8gZG9fZmF1bHQ7CiAgICAgICAgIH0KIAotICAgICAgICAvKiBUaGUgQUJJ
IGxlbmd0aCBleGNsdWRlcyB0aGUgZmlsZW5hbWUncyB0ZXJtaW5hdGluZyBOVUwuICovCi0gICAg
ICAgIGZpbGVuYW1lX3NpemUgPSAoc2l6ZV90KWZpbGVuYW1lX2xlbiArIDE7Ci0gICAgICAgIGZp
bGVuYW1lID0gbG9ja191c2VyKFZFUklGWV9SRUFELCBwaHlzaWNhbF9maWxlbmFtZV9hZGRyLAot
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBmaWxlbmFtZV9zaXplLCB0cnVlKTsKLSAgICAg
ICAgaWYgKCFmaWxlbmFtZSB8fCBmaWxlbmFtZVtmaWxlbmFtZV9sZW5dICE9ICdcMCcpIHsKLSAg
ICAgICAgICAgIHVubG9ja191c2VyKGZpbGVuYW1lLCBwaHlzaWNhbF9maWxlbmFtZV9hZGRyLCAw
KTsKLSAgICAgICAgICAgIGdvdG8gZG9fZmF1bHQ7CisgICAgICAgIGlmIChsZW5ndGggPj0gQlVG
U0laKSB7CisgICAgICAgICAgICBxZW11X2xvZ19tYXNrKExPR19HVUVTVF9FUlJPUiwKKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgIiVzOiBmaWxlbmFtZSB0b28gbGFyZ2UgKCUiIFBSSXUzMiAi
KVxuIiwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgX19mdW5jX18sIGxlbmd0aCk7CisgICAg
ICAgICAgICBzZW1pX2NiKGNzLCAtMSwgRU5BTUVUT09MT05HKTsKKyAgICAgICAgICAgIGJyZWFr
OwogICAgICAgICB9CiAKKyAgICAgICAgZG8geworICAgICAgICAgICAgaWYgKGdldF91c2VyX3U4
KGZpbGVuYW1lW2ldLCBwaHlzaWNhbF9maWxlbmFtZV9hZGRyICsgaSkpIHsKKyAgICAgICAgICAg
ICAgICBnb3RvIGRvX2ZhdWx0OworICAgICAgICAgICAgfQorICAgICAgICAgICAgaSsrOworICAg
ICAgICB9IHdoaWxlIChmaWxlbmFtZVtpIC0gMV0pOworCiAgICAgICAgIC8qIGNvbnZlcnQgQVJN
IEFOR0VMIGZpbGVtb2RlIGludG8gaG9zdCBmaWxlbW9kZSAqLwogICAgICAgICBpZiAoZmlsZW1v
ZGUgPCBBUlJBWV9TSVpFKGFuZ2VsX3RvX2hvc3RfZmlsZW1vZGVfdGFibGUpKSB7CiAgICAgICAg
ICAgICByZWFsX29wZW5tb2RlID0gYW5nZWxfdG9faG9zdF9maWxlbW9kZV90YWJsZVtmaWxlbW9k
ZV07CkBAIC01MDMsNyArNTA5LDYgQEAgc3RhdGljIHZvaWQgc2ltX2hhbmRsZV90cmFwMChDUFVI
ZXhhZ29uU3RhdGUgKmVudikKICAgICAgICAgICAgIHFlbXVfbG9nX21hc2soTE9HX0dVRVNUX0VS
Uk9SLAogICAgICAgICAgICAgICAgICAgICAgICAgICAiJXM6IGludmFsaWQgT1BFTiBtb2RlOiAl
dVxuIiwKICAgICAgICAgICAgICAgICAgICAgICAgICAgX19mdW5jX18sIGZpbGVtb2RlKTsKLSAg
ICAgICAgICAgIHVubG9ja191c2VyKGZpbGVuYW1lLCBwaHlzaWNhbF9maWxlbmFtZV9hZGRyLCAw
KTsKICAgICAgICAgICAgIHNlbWlfY2IoY3MsIC0xLCBFSU5WQUwpOwogICAgICAgICAgICAgYnJl
YWs7CiAgICAgICAgIH0KQEAgLTUyMyw3ICs1MjgsNiBAQCBzdGF0aWMgdm9pZCBzaW1faGFuZGxl
X3RyYXAwKENQVUhleGFnb25TdGF0ZSAqZW52KQogICAgICAgICAgICAgICAgIHJldCA9IGd1ZXN0
ZmQ7CiAgICAgICAgICAgICB9CiAgICAgICAgIH0KLSAgICAgICAgdW5sb2NrX3VzZXIoZmlsZW5h
bWUsIHBoeXNpY2FsX2ZpbGVuYW1lX2FkZHIsIDApOwogICAgICAgICBzZW1pX2NiKGNzLCByZXQs
IGVycik7CiAgICAgfQogICAgIGJyZWFrOwpAQCAtNTY4LDcgKzU3Miw3IEBAIHN0YXRpYyB2b2lk
IHNpbV9oYW5kbGVfdHJhcDAoQ1BVSGV4YWdvblN0YXRlICplbnYpCiAgICAgICAgIHN0cnVjdCBz
dGF0IHN0X2J1ZjsKICAgICAgICAgdWludDhfdCAqc3RfYnVmcHRyID0gKHVpbnQ4X3QgKikmc3lz
X3N0YXQ7CiAgICAgICAgIGludCByYywgZXJyID0gMDsKLSAgICAgICAgY2hhciAqZmlsZW5hbWU7
CisgICAgICAgIGNoYXIgZmlsZW5hbWVbQlVGU0laXTsKICAgICAgICAgdGFyZ2V0X3Vsb25nIHBo
eXNpY2FsX2ZpbGVuYW1lX2FkZHI7CiAgICAgICAgIHRhcmdldF91bG9uZyBzdGF0QnVmZmVyQWRk
cjsKICAgICAgICAgaWYgKGdldF91c2VyX3UzMihwaHlzaWNhbF9maWxlbmFtZV9hZGRyLCBzd2lf
aW5mbykgfHwKQEAgLTU3NywxNCArNTgxLDE1IEBAIHN0YXRpYyB2b2lkIHNpbV9oYW5kbGVfdHJh
cDAoQ1BVSGV4YWdvblN0YXRlICplbnYpCiAgICAgICAgIH0KIAogICAgICAgICBpZiAod2hhdF9z
d2kgPT0gSEVYX1NZU19TVEFUKSB7Ci0gICAgICAgICAgICBmaWxlbmFtZSA9IGxvY2tfdXNlcl9z
dHJpbmcocGh5c2ljYWxfZmlsZW5hbWVfYWRkcik7Ci0gICAgICAgICAgICBpZiAoIWZpbGVuYW1l
KSB7Ci0gICAgICAgICAgICAgICAgc2VtaV9jYihjcywgLTEsIEVGQVVMVCk7Ci0gICAgICAgICAg
ICAgICAgYnJlYWs7Ci0gICAgICAgICAgICB9CisgICAgICAgICAgICBpbnQgaSA9IDA7CisgICAg
ICAgICAgICBkbyB7CisgICAgICAgICAgICAgICAgaWYgKGdldF91c2VyX3U4KGZpbGVuYW1lW2ld
LCBwaHlzaWNhbF9maWxlbmFtZV9hZGRyICsgaSkpIHsKKyAgICAgICAgICAgICAgICAgICAgZ290
byBkb19mYXVsdDsKKyAgICAgICAgICAgICAgICB9CisgICAgICAgICAgICAgICAgaSsrOworICAg
ICAgICAgICAgfSB3aGlsZSAoKGkgPCBCVUZTSVopICYmIGZpbGVuYW1lW2kgLSAxXSk7CiAgICAg
ICAgICAgICByYyA9IHN0YXQoZmlsZW5hbWUsICZzdF9idWYpOwogICAgICAgICAgICAgZXJyID0g
ZXJybm87Ci0gICAgICAgICAgICB1bmxvY2tfdXNlcihmaWxlbmFtZSwgcGh5c2ljYWxfZmlsZW5h
bWVfYWRkciwgMCk7CiAgICAgICAgIH0gZWxzZSB7CiAgICAgICAgICAgICBpbnQgZmQgPSBwaHlz
aWNhbF9maWxlbmFtZV9hZGRyOwogICAgICAgICAgICAgR3Vlc3RGRCAqZ2YgPSBnZXRfZ3Vlc3Rm
ZChmZCk7CkBAIC02MzAsMjQgKzYzNSwyNiBAQCBzdGF0aWMgdm9pZCBzaW1faGFuZGxlX3RyYXAw
KENQVUhleGFnb25TdGF0ZSAqZW52KQogCiAgICAgY2FzZSBIRVhfU1lTX0FDQ0VTUzoKICAgICB7
Ci0gICAgICAgIGNoYXIgKmZpbGVuYW1lOworICAgICAgICBjaGFyIGZpbGVuYW1lW0JVRlNJWl07
CiAgICAgICAgIHVpbnQzMl90IEZpbGVOYW1lQWRkcjsKICAgICAgICAgdWludDMyX3QgQnVmZmVy
TW9kZTsKLSAgICAgICAgaW50IHJjLCBlcnI7CisgICAgICAgIGludCByYzsKKworICAgICAgICBp
bnQgaSA9IDA7CiAKICAgICAgICAgaWYgKGdldF91c2VyX3UzMihGaWxlTmFtZUFkZHIsIHN3aV9p
bmZvKSB8fAogICAgICAgICAgICAgZ2V0X3VzZXJfdTMyKEJ1ZmZlck1vZGUsIHN3aV9pbmZvICsg
NCkpIHsKICAgICAgICAgICAgIGdvdG8gZG9fZmF1bHQ7CiAgICAgICAgIH0KLSAgICAgICAgZmls
ZW5hbWUgPSBsb2NrX3VzZXJfc3RyaW5nKEZpbGVOYW1lQWRkcik7Ci0gICAgICAgIGlmICghZmls
ZW5hbWUpIHsKLSAgICAgICAgICAgIHNlbWlfY2IoY3MsIC0xLCBFRkFVTFQpOwotICAgICAgICAg
ICAgYnJlYWs7Ci0gICAgICAgIH0KKyAgICAgICAgZG8geworICAgICAgICAgICAgaWYgKGdldF91
c2VyX3U4KGZpbGVuYW1lW2ldLCBGaWxlTmFtZUFkZHIgKyBpKSkgeworICAgICAgICAgICAgICAg
IGdvdG8gZG9fZmF1bHQ7CisgICAgICAgICAgICB9CisgICAgICAgICAgICBpKys7CisgICAgICAg
IH0gd2hpbGUgKChpIDwgQlVGU0laKSAmJiAoZmlsZW5hbWVbaSAtIDFdKSk7CisgICAgICAgIGZp
bGVuYW1lW2ldID0gMDsKICAgICAgICAgcmMgPSBhY2Nlc3MoZmlsZW5hbWUsIEJ1ZmZlck1vZGUp
OwotICAgICAgICBlcnIgPSBlcnJubzsKLSAgICAgICAgdW5sb2NrX3VzZXIoZmlsZW5hbWUsIEZp
bGVOYW1lQWRkciwgMCk7Ci0gICAgICAgIHNlbWlfY2IoY3MsIHJjLCAgcmMgPT0gMCA/IDAgOiBl
cnIpOworICAgICAgICBzZW1pX2NiKGNzLCByYywgIHJjID09IDAgPyAwIDogZXJybm8pOwogICAg
IH0KICAgICBicmVhazsKIAotLSAKMi4zNC4xCgo=

