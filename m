Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E16E3CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 20:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9rPx-0004TU-2p; Fri, 17 Oct 2025 16:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1v9rPn-0004Ru-BH
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 16:51:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1v9rPf-00031r-9h
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 16:51:05 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59HJG9Fg015055
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 20:50:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 P1lPeIurrz5lApASiWHSBGIjinJz71iJh+Tuc+ZQZuY=; b=mPrzFRvgjJ2GKLMk
 JvnRT27AQvKqYUSwOgRnEAyZOrFcb8VAmYibNJs1SeJRFB0VYhvxasn5+EdYfQnA
 sfl637V0YlKpbxeBzLSXV8viS6il6eMGD2IQDr6BXReQlyH29DsNY8cwDJKRcdtX
 NbQ0IEYFxxcH3/QJD7Cqop10jI7VLjg1mt6YfLAs29TTbD95SqVevJFHZZPv2JSr
 WCvGn8DS1GJyqU70dKPINNDI+mD185JVZ2PhqOiaR9SoU4ytY3gKIundVblswMxv
 o+bQTyNofSkplQouDBF31SpfdvzLvKj+GroWs1dW7y2F+xO1COLUF6nsZTBJG2/d
 J8bkbA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49sua8vdkx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 20:50:58 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-782063922ceso2316035b3a.0
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 13:50:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760734256; x=1761339056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P1lPeIurrz5lApASiWHSBGIjinJz71iJh+Tuc+ZQZuY=;
 b=b1oD++P9YmR42IcD46Ye1FYJ/lDL59UPFOp/x84Y3edvJrtuJkpHwDwLbQnqDlAiuL
 oGcfZhlf0WE/zGPPVYe8G/G0C6OcU1NChrQX6PCk+8St7sZozIDd6NWY37/Uoc5+4o9V
 cu1nxsWzKQiYgfTpBmGjbyTml22gtMMPLaEI/FKuM48f6oBGDo7ZmOCWBCpikB0axlwX
 fseZjZykaf5g2aCZim6ZWEvtlFbMV9DyV871FbNjD9o6p0gyN6Oo3j1MWU/gGQPicRXA
 1SW0UC2BkCHzJmhIZO7HjVNGRwuY/Y5TPsm3EmjZrs2kWWnn1QmMhZY+MfhaM6sOxiXr
 SFEw==
X-Gm-Message-State: AOJu0YxSUPqI/5UVDTvYmbX8/1CBR4IkkRFFZTtc1CPKRPCM4SGmH2BU
 0ArQLj4Fb4D+VMAFtdW/TBth48gxr72IurMTusDL7Hq+TEOc0ClbB/VE/lMGyjPb+BvfHOu4QK7
 eyL1yosRLjOZ7J3rpZgWl90pl4XW5Wkt3urp5rK4+Yv+CVTGBsqxdYYMaJUB4k1Vb0A==
X-Gm-Gg: ASbGncuOAzcD8J4R/GpVb3CsphKOysSpjzHqrPqtVOvsPtEjV7YXGCBtcL+4bqb2Dx9
 +N7V4VgtS/iheGBwSTLyYCrWNs0t3qsZTmSCynkgzmVzKhYmczGaaASGuXafeqTHCDloZIvrr7C
 UeBsAs2sZ6eN9Ubu65TMGA4n0sdQfdEhNOTTpEDW1npR/exIe2cCfZ5JBSwu8kzXtDYbYi+uVof
 fCASgqEnGy73mT85+NOHumr+HGRD3szsPe8K2tSUBZdek8cFx2kTfdNHOV25wjePda9QMo/Z4dT
 Vo9NbPcVe0TpuHyeJEik7uTbP5h024lnNET8ci+UkijFwLMDByVzpeGi0PgSn1rYkO+FLiEhiZd
 ElkeC7dMUwJXT4UubyKuI9KQFwc+gs579U52dbSUL2iOfcfI=
X-Received: by 2002:a05:6a00:189a:b0:781:15b0:beb4 with SMTP id
 d2e1a72fcca58-7a220b10752mr5125780b3a.21.1760734256521; 
 Fri, 17 Oct 2025 13:50:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzjDeMj7CIZl6FV5xIhw5PO9KADD6TaBszw2QA6aLGQbdUag9+u034zr31JPSckCWIlz606g==
X-Received: by 2002:a05:6a00:189a:b0:781:15b0:beb4 with SMTP id
 d2e1a72fcca58-7a220b10752mr5125765b3a.21.1760734256065; 
 Fri, 17 Oct 2025 13:50:56 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a2300f251fsm495080b3a.39.2025.10.17.13.50.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 13:50:55 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 Anton Johansson <anjo@rev.ng>
Subject: [PULL 7/8] target/hexagon: Replace `prepare` script with meson target
Date: Fri, 17 Oct 2025 13:50:27 -0700
Message-Id: <20251017205028.1105595-8-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251017205028.1105595-1-brian.cain@oss.qualcomm.com>
References: <20251017205028.1105595-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: QqSwlD6IGV7RjEXbY0rGpOdeVGO27QT-
X-Authority-Analysis: v=2.4 cv=e5MLiKp/ c=1 sm=1 tr=0 ts=68f2ac32 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=mDV3o1hIAAAA:8 a=EUspDBNiAAAA:8 a=2X-aW2C2GcTeERE7ZgAA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE0MDEzNCBTYWx0ZWRfXzd2kvbZ76lc1
 v+CYOOpyY9rc7+wmRM+i2fFNsjORAVGs2awIAClRHxCmwLcvdfjawSf5kFNKhNB7MnszCMjbxN8
 58j35qkaKM0MbaEPaXrBfta6fhoZz1VwHG0cDXuDoi18NLB29lSd3vEhAHose4i2oDMX7/Kpsv5
 iVLYHRPwtSqDy5gFiSNZzSkI2cUlsuR35578VwaM/GFWrSWiT3qghVSw+AY4u/TbmHW8ib9m+B8
 MnbNB0YmyA0txdBE6KlakXZUehBEYFrfpL3RJBXbgafy1DXQvnA/ZlhmMdhgDYKMBOa9JmPUjGT
 7xzCiVDektBhRhTyMVV2qJ4/4veiyWZhfNfH5Gg4Czuzvb9VW9gFeHxNDPb/Xoc8Rc+GjH8ykVS
 YpDJpdWow+OYTAq/P7K50U7Qxyo1tw==
X-Proofpoint-ORIG-GUID: QqSwlD6IGV7RjEXbY0rGpOdeVGO27QT-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510140134
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

RnJvbTogQW50b24gSm9oYW5zc29uIDxhbmpvQHJldi5uZz4KClRoZSBwdXJwb3NlIG9mIHRoZSBw
cmVwYXJlIHNjcmlwdCBpcyB0byBpbnZva2UgYGNwcGAgdG8gcHJlcHJvY2VzcyBpbnB1dAp0byBp
ZGVmLXBhcnNlciBieSBleHBhbmRpbmcgYSBmZXcgc2VsZWN0IG1hY3Jvcy4gIE9uIG1hY09TIGBj
cHBgCmV4cGFuZHMgaW50byBgY2xhbmcgLi4uIC10cmFkaXRpb25hbC1jcHBgIHdoaWNoIGJyZWFr
cyBtYWNybwpjb25jYXRlbmF0aW9uLiAgUmVwbGFjZSBgY3BwYCB3aXRoIGAke2NvbXBpbGVyfSAt
RWAKYW5kIHJlcGxhY2UgdGhlIHNjcmlwdCB3aXRoIGEgbWVzb24gY3VzdG9tX3RhcmdldC4KClNp
Z25lZC1vZmYtYnk6IEFudG9uIEpvaGFuc3NvbiA8YW5qb0ByZXYubmc+ClJldmlld2VkLWJ5OiBC
cmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJy
aWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdv
bi9pZGVmLXBhcnNlci9wcmVwYXJlIHwgMjQgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiB0YXJn
ZXQvaGV4YWdvbi9tZXNvbi5idWlsZCAgICAgICAgIHwgIDMgKystCiAyIGZpbGVzIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKSwgMjUgZGVsZXRpb25zKC0pCiBkZWxldGUgbW9kZSAxMDA3NTUgdGFy
Z2V0L2hleGFnb24vaWRlZi1wYXJzZXIvcHJlcGFyZQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhh
Z29uL2lkZWYtcGFyc2VyL3ByZXBhcmUgYi90YXJnZXQvaGV4YWdvbi9pZGVmLXBhcnNlci9wcmVw
YXJlCmRlbGV0ZWQgZmlsZSBtb2RlIDEwMDc1NQppbmRleCBjYjM2MjJkNGY4Li4wMDAwMDAwMDAw
Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2lkZWYtcGFyc2VyL3ByZXBhcmUKKysrIC9kZXYvbnVsbApA
QCAtMSwyNCArMCwwIEBACi0jIS91c3IvYmluL2VudiBiYXNoCi0KLSMKLSMgIENvcHlyaWdodChj
KSAyMDE5LTIwMjEgcmV2Lm5nIExhYnMgU3JsLiBBbGwgUmlnaHRzIFJlc2VydmVkLgotIwotIyAg
VGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFu
ZC9vciBtb2RpZnkKLSMgIGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVi
bGljIExpY2Vuc2UgYXMgcHVibGlzaGVkIGJ5Ci0jICB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0
aW9uOyBlaXRoZXIgdmVyc2lvbiAyIG9mIHRoZSBMaWNlbnNlLCBvcgotIyAgKGF0IHlvdXIgb3B0
aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4KLSMKLSMgIFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRl
ZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNlZnVsLAotIyAgYnV0IFdJVEhPVVQgQU5Z
IFdBUlJBTlRZOyB3aXRob3V0IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFudHkgb2YKLSMgIE1FUkNI
QU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4gIFNlZSB0aGUK
LSMgIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGZvciBtb3JlIGRldGFpbHMuCi0jCi0jICBZ
b3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQgYSBjb3B5IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMg
TGljZW5zZQotIyAgYWxvbmcgd2l0aCB0aGlzIHByb2dyYW07IGlmIG5vdCwgc2VlIDxodHRwOi8v
d3d3LmdudS5vcmcvbGljZW5zZXMvPi4KLSMKLQotc2V0IC1lCi1zZXQgLW8gcGlwZWZhaWwKLQot
IyBSdW4gdGhlIHByZXByb2Nlc3NvciBhbmQgZHJvcCBjb21tZW50cwotY3BwICIkQCIKZGlmZiAt
LWdpdCBhL3RhcmdldC9oZXhhZ29uL21lc29uLmJ1aWxkIGIvdGFyZ2V0L2hleGFnb24vbWVzb24u
YnVpbGQKaW5kZXggYmI0ZWJhYWU4MS4uYWJjZjAwY2ExZiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hl
eGFnb24vbWVzb24uYnVpbGQKKysrIGIvdGFyZ2V0L2hleGFnb24vbWVzb24uYnVpbGQKQEAgLTI4
MCwxMiArMjgwLDEzIEBAIGlmIGlkZWZfcGFyc2VyX2VuYWJsZWQgYW5kICdoZXhhZ29uLWxpbnV4
LXVzZXInIGluIHRhcmdldF9kaXJzCiAgICAgICAgIGNvbW1hbmQ6IFtweXRob24sIGZpbGVzKCdn
ZW5faWRlZl9wYXJzZXJfZnVuY3MucHknKSwgc2VtYW50aWNzX2dlbmVyYXRlZCwgJ0BPVVRQVVRA
J10sCiAgICAgKQogCisgICAgY29tcGlsZXIgPSBtZXNvbi5nZXRfY29tcGlsZXIoJ2MnKS5nZXRf
aWQoKQogICAgIHByZXByb2Nlc3NlZF9pZGVmX3BhcnNlcl9pbnB1dF9nZW5lcmF0ZWQgPSBjdXN0
b21fdGFyZ2V0KAogICAgICAgICAnaWRlZl9wYXJzZXJfaW5wdXQucHJlcHJvY2Vzc2VkLmguaW5j
JywKICAgICAgICAgb3V0cHV0OiAnaWRlZl9wYXJzZXJfaW5wdXQucHJlcHJvY2Vzc2VkLmguaW5j
JywKICAgICAgICAgaW5wdXQ6IGlkZWZfcGFyc2VyX2lucHV0X2dlbmVyYXRlZCwKICAgICAgICAg
ZGVwZW5kX2ZpbGVzOiBbaWRlZl9wYXJzZXJfZGlyIC8gJ21hY3Jvcy5oLmluYyddLAotICAgICAg
ICBjb21tYW5kOiBbaWRlZl9wYXJzZXJfZGlyIC8gJ3ByZXBhcmUnLCAnQElOUFVUQCcsICctSScg
KyBpZGVmX3BhcnNlcl9kaXIsICctbycsICdAT1VUUFVUQCddLAorICAgICAgICBjb21tYW5kOiBb
Y29tcGlsZXIsICcteCcsICdjJywgJy1FJywgJy1JJywgaWRlZl9wYXJzZXJfZGlyLCAnLW8nLCAn
QE9VVFBVVEAnLCAnQElOUFVUQCddLAogICAgICkKIAogICAgIGZsZXggPSBnZW5lcmF0b3IoCi0t
IAoyLjM0LjEKCg==

