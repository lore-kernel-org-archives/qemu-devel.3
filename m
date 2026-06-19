Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09196CDB46B
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 23:05:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waiCQ-00034K-Q1; Fri, 19 Jun 2026 19:00:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waiC7-0002K8-GB
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:00:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waiC5-0001fn-Kl
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:00:15 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JLY2JY2933379
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:00:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RwPVW3CwUQS2/lnObn+K7hYU+7Hhy6ohC8oxC7MFC5M=; b=SskkKHaViyHzvbZy
 xnX07d/cfJihTpher3Xd4A0AxnD001muO0ZBDJhq91EosDxufRGLj164SFTyPeHG
 22LQgiGoYdhkBk6cXCEbEN+1JHIClcI8rChFrLMdrZ5kQBclLQWHSjI6NAmiJlQh
 m6eWhjMApy0UmX1EhuN2OExQONXx+Qb4ehdQiiMXrWjEbAZZBkgKucdFPA154IUU
 DfhJaGGRTlHdPL4rEtllYm/vvxRmX/R7jQMwc37OTGk5j3I+sT5voHE2O0bXykWm
 kb06ogdOeI7xD+EJ2na6fNj0OobDgA+c6s6AQlWSrGERct4tmUKAKY0+1WNTQxCR
 oWNmVw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ew5qsa2wj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:00:02 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30c13bb8ca9so1225473eec.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 16:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781910001; x=1782514801; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RwPVW3CwUQS2/lnObn+K7hYU+7Hhy6ohC8oxC7MFC5M=;
 b=iINh14CV8G0TtoMLDhEc5bAJZEHFpzpdt2tX3BWKpihqO9Z4nmD+XhYHSq+0LFOfRZ
 nmYQtT8ow0T9FHcwN+SM6d38MIaUWhA5DO97g5mHfi8ZhnHVxDrj3A1ZgDllyp8y1spc
 8JQJEku+CUV77O1U/tlqQxhsOTYtcF/LPhQ1xFL5eFHx0p6cCraEpvxU4N9VJaJeSGj1
 jSolqfTRpY6vBJdnFreF54pKnOtq/G/KF02pAH6KJbvaWYEH6BjpyELcrSh97/Hq7M/5
 dAHc8ABqr9GHtWrgcUtd+Z/ELcTPBdhsXb+lnPqhjRuya3117Z8xl2AJuewoTshak9+G
 RFzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781910001; x=1782514801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RwPVW3CwUQS2/lnObn+K7hYU+7Hhy6ohC8oxC7MFC5M=;
 b=GBmtGUADgzjNKHrBadRyq498DGPK3awq5mmYORiwTHOSCZMzzO7W9zOe6KpC4nu5px
 U+q3cR++08F49xK+VLvwG/H5YBzI+sNOfk0gMR8eelPoP7adDfrijONThw5fkKOfSa5l
 UNlpRXxidcpPYy3vO2CL6GGMkSYwWLh9u3VTkjbr1Zjd0pjd9rv2cNc8itxWF6AmT3YG
 a0oMZGnxUpQTWg7cwVmKvdUcLV9Et4ikUvsKackOVpiz4BMLXs1c2aNZlQJS4QPZA1ME
 5WpSkofB44XUFj5pt465vy88cdgjDOBY5rbEB7h9xsZyWXhGFsgUGExiZ3jKoTQd6dTb
 fnrQ==
X-Gm-Message-State: AOJu0YxZsbm405YTpkeZAa8Ut1huCsYE8WQbMQea49fwTtbt/GkSknrK
 MCcppLzwf2iXsfcWGG2atg4TNSxkvEDj3bSxb6YAwvPR3rx9xn2oIVga1nquXzorFSlX7jFsI27
 gS8otq2ES3Dr4KozPX1TXRPuyodEz7dUSSWKi8gcJGYSQXZcPu26Hj9XFCUSkBjOOTg==
X-Gm-Gg: AfdE7cnxSQ32V8WRktaYlkj5ppwWRMPOAGxel4Mc3CisWK3wr5QVPdFdbZjYOux3QGf
 mKEzAx/fGpV3i8btjnZ0vUG5TE1ixpH9TkO6UQN5XcZAjxXFINQTNkRH7I7YOJ3TjUSaS2ZH+Pg
 NOwiom9sKAz0EyXlX529nuB8YUdhDml4LSpqnxb+/dfbLNv+w3zzYC+ZctpjHstbmFQRqjueLbs
 M8DW+O9iGESBNFo5VPBJ1EN2eTkuVh7IrGVxu2JvSiwHTdKE4UcRHdnSaWW2UQUZLqqKXSBRsIf
 jQ2lZSXGeCJ2XmxeF06NEKwG2fvr8yMkhxD8GE5AHXV3xh3j377BM6hyJJIeEhsP3ad4kYQPNIx
 Yoifczb+oHPVb9J+jJ1ZrSvF/IiOCajTzGsfFJkb4RjXGH8ryRnkJoXJibrk=
X-Received: by 2002:a05:693c:2d8f:b0:30b:eb27:d415 with SMTP id
 5a478bee46e88-30c070edf73mr3481260eec.22.1781910001459; 
 Fri, 19 Jun 2026 16:00:01 -0700 (PDT)
X-Received: by 2002:a05:693c:2d8f:b0:30b:eb27:d415 with SMTP id
 5a478bee46e88-30c070edf73mr3481252eec.22.1781910000917; 
 Fri, 19 Jun 2026 16:00:00 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1b4f7d81sm1309510eec.0.2026.06.19.15.59.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 15:59:59 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 32/74] target/hexagon: Add cpu modes, mmu indices,
 next_PC to state
Date: Fri, 19 Jun 2026 15:58:29 -0700
Message-Id: <20260619225911.159473-33-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
References: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIyMSBTYWx0ZWRfX8sLq+FBZGvjR
 HfbJHfO2LFjYevVnT0Oq8pULP0en6+qisXXHHLEICcVuagBsk/bdzCqNZMawSt47SXwxGiW0W+7
 +OtYtdevPRVtTDNGbKybAhPkUSTAzr26LV2aSdm7Wg3qXzB5XEBpqzq8qnDWAv3xOxjkgix6TBM
 GSMVkkRXyPOotH3hx61L3ShEcdMn1pRghia5OjQG8/qmeuiBXHCmA000Qje8ASDCoA/R07+EXjC
 Yv4JyP1iSF295+T9+o/m9eAceittcEH0Jf1WjuQwjkFMHWSBfVR7+oxtw+1c+ovprYknixiSzqE
 oocDrNwS1ukNmA4tGgdLdGAfshZKiAdQ0KD8PtWlDbSUN0vqZL3ftuxMsb05+q5m7CbO6gkUCFl
 XwvGbGnVeATjgYXCKilBMiv9wJUmIF9ZMItIs8373cEmaVpeUwnQE84Q2B7oPUIgxviHG72ld1v
 z/lHbKA6KTYTpcbUGQA==
X-Authority-Analysis: v=2.4 cv=M9R97Sws c=1 sm=1 tr=0 ts=6a35c9f2 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=StfCoqezVcLOyubjZekA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: aJMFyXr1W_wJS3PLRiiBwaXyddK1GFLI
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIyMSBTYWx0ZWRfX5RxGao1OIH9m
 6wz3mFo4hiYKnDdEVn47X15ztTqESiAQV6VR92PP1sYdvhvxnW3jgVUr7xlXIaIfSBG66Ymf0Nx
 1Du91u95JtvCxPHLLQRWlxGEBt3b+b8=
X-Proofpoint-GUID: aJMFyXr1W_wJS3PLRiiBwaXyddK1GFLI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606190221
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpBZGQgY3B1IGV4ZWN1dGlvbiBt
b2RlICh1c2VyL3N1cGVydmlzb3IvZ3Vlc3QpLCBNTVUgaW5kZXgsIGFuZCBuZXh0X1BDCnRvIERp
c2FzQ29udGV4dCBhbmQgdHJhbnNsYXRpb24gc3RhdGUuIERlY2xhcmUgdGhlIE1NVV9JTkRFWCBi
aXQgZmllbGQKaW4gVEJfRkxBR1MgYW5kIHVzZSBpdCB0byBwcm9wYWdhdGUgdGhlIG1tdSBpbmRl
eCBpbnRvIHRyYW5zbGF0aW9ucy4KClJldmlld2VkLWJ5OiBUYXlsb3IgU2ltcHNvbiA8bHRheWxv
cnNpbXBzb25AZ21haWwuY29tPgpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJp
Y2suYm91dmllckBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxi
cmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vY3B1LmggICAg
ICAgfCAyMiArKysrKysrKysrKysrKysrKysrKystCiB0YXJnZXQvaGV4YWdvbi9jcHUuYyAgICAg
ICB8ICAxICsKIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jIHwgIDIgKy0KIDMgZmlsZXMgY2hh
bmdlZCwgMjMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90YXJn
ZXQvaGV4YWdvbi9jcHUuaCBiL3RhcmdldC9oZXhhZ29uL2NwdS5oCmluZGV4IGRkZjZkYTc4YzE4
Li43YmExZDMwNDdkZiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1LmgKKysrIGIvdGFy
Z2V0L2hleGFnb24vY3B1LmgKQEAgLTQ5LDggKzQ5LDI2IEBACiAjZGVmaW5lIFZTVE9SRVNfTUFY
IDIKIAogI2RlZmluZSBDUFVfUkVTT0xWSU5HX1RZUEUgVFlQRV9IRVhBR09OX0NQVQorI2lmbmRl
ZiBDT05GSUdfVVNFUl9PTkxZCisjZGVmaW5lIENQVV9JTlRFUlJVUFRfU1dJICAgICAgQ1BVX0lO
VEVSUlVQVF9UR1RfSU5UXzAKKworI2RlZmluZSBIRVhfQ1BVX01PREVfVVNFUiAgICAxCisjZGVm
aW5lIEhFWF9DUFVfTU9ERV9HVUVTVCAgIDIKKyNkZWZpbmUgSEVYX0NQVV9NT0RFX01PTklUT1Ig
MworCisjZGVmaW5lIEhFWF9FWEVfTU9ERV9PRkYgICAgIDEKKyNkZWZpbmUgSEVYX0VYRV9NT0RF
X1JVTiAgICAgMgorI2RlZmluZSBIRVhfRVhFX01PREVfV0FJVCAgICAzCisjZGVmaW5lIEhFWF9F
WEVfTU9ERV9ERUJVRyAgIDQKKyNlbmRpZgorCisjZGVmaW5lIE1NVV9VU0VSX0lEWCAgICAgICAg
IDAKKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorI2RlZmluZSBNTVVfR1VFU1RfSURYICAgICAg
ICAxCisjZGVmaW5lIE1NVV9LRVJORUxfSURYICAgICAgIDIKKworI2VuZGlmCiAKLSNkZWZpbmUg
TU1VX1VTRVJfSURYIDAKIAogI2RlZmluZSBIRVhBR09OX0NQVV9JUlFfMCAwCiAjZGVmaW5lIEhF
WEFHT05fQ1BVX0lSUV8xIDEKQEAgLTExMiw2ICsxMzAsNyBAQCB0eXBlZGVmIHN0cnVjdCBDUFVB
cmNoU3RhdGUgewogICAgIHVpbnQzMl90IHRocmVhZElkOwogICAgIHVpbnQ2NF90IHRfY3ljbGVf
Y291bnQ7CiAjZW5kaWYKKyAgICB1aW50MzJfdCBuZXh0X1BDOwogICAgIHRhcmdldF91bG9uZyBu
ZXdfdmFsdWVfdXNyOwogCiAgICAgTWVtTG9nIG1lbV9sb2dfc3RvcmVzW1NUT1JFU19NQVhdOwpA
QCAtMTY0LDYgKzE4Myw3IEBAIHN0cnVjdCBBcmNoQ1BVIHsKICNpbmNsdWRlICJjcHVfYml0cy5o
IgogCiBGSUVMRChUQl9GTEFHUywgSVNfVElHSFRfTE9PUCwgMCwgMSkKK0ZJRUxEKFRCX0ZMQUdT
LCBNTVVfSU5ERVgsIDEsIDMpCiBGSUVMRChUQl9GTEFHUywgUENZQ0xFX0VOQUJMRUQsIDQsIDEp
CiAKIEdfTk9SRVRVUk4gdm9pZCBoZXhhZ29uX3JhaXNlX2V4Y2VwdGlvbl9lcnIoQ1BVSGV4YWdv
blN0YXRlICplbnYsCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHUuYyBiL3RhcmdldC9o
ZXhhZ29uL2NwdS5jCmluZGV4IDA3NzNlZjhmZTc5Li42MjYxMDBkNDNmZCAxMDA2NDQKLS0tIGEv
dGFyZ2V0L2hleGFnb24vY3B1LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKQEAgLTMwNyw2
ICszMDcsNyBAQCBzdGF0aWMgdm9pZCBoZXhhZ29uX2NwdV9yZXNldF9ob2xkKE9iamVjdCAqb2Jq
LCBSZXNldFR5cGUgdHlwZSkKICAgICBtZW1zZXQoZW52LT50X3NyZWcsIDAsIHNpemVvZih1aW50
MzJfdCkgKiBOVU1fU1JFR1MpOwogICAgIG1lbXNldChlbnYtPmdyZWcsIDAsIHNpemVvZih1aW50
MzJfdCkgKiBOVU1fR1JFR1MpOwogICAgIGVudi0+d2FpdF9uZXh0X3BjID0gMDsKKyAgICBlbnYt
Pm5leHRfUEMgPSAwOwogI2VuZGlmCiAgICAgZW52LT5jYXVzZV9jb2RlID0gSEVYX0VWRU5UX05P
TkU7CiB9CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyBiL3RhcmdldC9o
ZXhhZ29uL3RyYW5zbGF0ZS5jCmluZGV4IGVkOTZkOWE2NmIzLi5jZTViYmU5MmQ1ZCAxMDA2NDQK
LS0tIGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vdHJh
bnNsYXRlLmMKQEAgLTk4OCw3ICs5ODgsNyBAQCBzdGF0aWMgdm9pZCBoZXhhZ29uX3RyX2luaXRf
ZGlzYXNfY29udGV4dChEaXNhc0NvbnRleHRCYXNlICpkY2Jhc2UsCiAgICAgSGV4YWdvbkNQVSAq
aGV4X2NwdSA9IGVudl9hcmNoY3B1KGNwdV9lbnYoY3MpKTsKICAgICB1aW50MzJfdCBoZXhfZmxh
Z3MgPSBkY2Jhc2UtPnRiLT5mbGFnczsKIAotICAgIGN0eC0+bWVtX2lkeCA9IE1NVV9VU0VSX0lE
WDsKKyAgICBjdHgtPm1lbV9pZHggPSBGSUVMRF9FWDMyKGhleF9mbGFncywgVEJfRkxBR1MsIE1N
VV9JTkRFWCk7CiAgICAgY3R4LT5udW1fcGFja2V0cyA9IDA7CiAgICAgY3R4LT5udW1faW5zbnMg
PSAwOwogICAgIGN0eC0+bnVtX2h2eF9pbnNucyA9IDA7Ci0tIAoyLjM0LjEKCg==

