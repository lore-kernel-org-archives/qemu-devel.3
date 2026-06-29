Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C150AC43327
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:13:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weBn4-0004I4-Mu; Mon, 29 Jun 2026 09:12:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weBn3-0004Hq-Eq
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:12:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weBn1-000370-P3
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:12:45 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TATKCY2656131
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:12:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=GLP31WMp9ya2aQSzhpJX7UU63XGBhoUjedxw7x1beJQ=; b=k9
 mAgTz+SFBKhYy/RVALM8dNCOaqgP7mbFy6lKTdnXjhj55e/1sZjYFljOSqpN05PC
 zgeIsuDLw8A8TCjHrkld37f6uKX7YUhLxSLY6y+aW8FkM8r+Wb0dSeJP1Q7ei4vq
 5qnb2uj2oaCaigb0SzbMVraDe7ZjknTbQoSRE6ftbimTTyZNT4cA4Rf7YV7Za5QQ
 UlzS21X+JYH5yBWLADp3rUO6E7h70eFh3Rq41VXm63wJ/g7Pa6C9O9OdZAC/uiYy
 hkpL+ueJH8TogJDrufnVhQ8HzVtNYoQIwZ3lkhsNbNw/Y69CyZz/j5pqDC3m9wjA
 /UiDl9Iyci27nHRwIhAw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3np7gxpx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:12:42 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-13af1bcb210so319103c88.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 06:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782738761; x=1783343561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GLP31WMp9ya2aQSzhpJX7UU63XGBhoUjedxw7x1beJQ=;
 b=Sh7iipQkEZjzMBkgFhdC0k/Pk0ffUAlgcfHyAhAcfOucDDRB7v1yFLo8k53N15DeKL
 KJiAyxPdmjS0TNw/bRFkxs4ZQ363nUT3ucqKGoBoSXSnI7jNokOVbZzmWxI9O0rOHs8l
 NpgxWO+wFGrMGxqA9uafhk+qdgyqz1SrI/7xPbSw/7fCxMcEDxctf4LdxhYnpyxXc3C5
 kpnxY7nqAGa45hZB2qPpVX5cCTro7FnmhlMJOo0AJkNheeO06cfyzvk5rIB1uPgsr/k1
 qJH7csIHBaf2B+OREIe4A30YNL1+vIFF1igQ6bg0QJxXW6xHugqJCWxkS3nRHNJ+93Wq
 DoOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782738761; x=1783343561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GLP31WMp9ya2aQSzhpJX7UU63XGBhoUjedxw7x1beJQ=;
 b=S5BcYrnQxdPwspirOV9Q/sF8S+7Kh/iODBjtjuFHx4mpjbLtbu2RAhgOfc5fZbyPIC
 S4Ny/0CBSU3jhaB0joHDWfut2vW6eJG0tIqlJivWWOoCGu3hROG4ORdnD9HzVUj5Mkl3
 YXKgSk4P4UQCtdozcotW7OgOLXOtC7xdSBpF1bI+0r6pVd1qGN8rfhjIxCWI26TBXpuu
 Sq8hLmquOzUy6Nf8CdU9m6JJbcCDjY+Oq729muICZqidGmzkT7lNRDCiCl4GY2mwIRmv
 qvFuXW+MSqzzvE2dM+RiSbBXwQILTF2lxfdKlhLMwGJEj50jalf9mbK1ZTRnryxWHxWT
 Sx3w==
X-Gm-Message-State: AOJu0YyP/Tv36cVv9TbsulVZiZramaLpWR/+QamNAEXtVtpQZwtRIPEL
 Xt+//JXDZvGa+yOZ2t0yX8Ea3BkXwM3db4oaynBc/UofrT/OC5AzLwVkfbrfOAfZzYe9hbjx6Fb
 bwLAtXR8PplCFOq+2QTHnlAss+SgzShxageCcl96VXg01Y00BKASVlZY+g0+wQpyCgA==
X-Gm-Gg: AfdE7cnhQPGyTsy1ziswG3hvW5KCheZefE3OA+TNaUojDZYJkTr084FMUvg1mCQte5n
 shMHhRiEuRUj/UnItSEtR3yjSP6ysQL5U3104JQVHJmA9Gx57Zx88lJsgre40UKv8i0K/henq6N
 1E+W46BDQpTw9Gl2tzMNvO9r/GHsgrjIxW55GgKVZZnakSm8fMiNo0Cm9cRaGbFTNhhUF3JG9KT
 eOmFoFm2xpixSChVe3/Y6lvuozNmfBT4lUcphbb+naI8sBArUBCKLL0t0gD2eqqG68C1bDWRwyO
 8zW342HA6gEodF2Stsv9/mOeo+Mzt4jXiYRw5I315+aTqQOMXQa/B/BVcknDwtDbWwvJf7WS4RW
 N1LfAMC5NeATkt5fZXi5AjSwNJ8Ro1FxxSzcg5gr8xDta6xJDJSmXXeqXeuA=
X-Received: by 2002:a05:7022:921:b0:133:39b9:9720 with SMTP id
 a92af1059eb24-139db9d6539mr12673314c88.16.1782738761409; 
 Mon, 29 Jun 2026 06:12:41 -0700 (PDT)
X-Received: by 2002:a05:7022:921:b0:133:39b9:9720 with SMTP id
 a92af1059eb24-139db9d6539mr12673296c88.16.1782738760838; 
 Mon, 29 Jun 2026 06:12:40 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139e78317f3sm28459106c88.9.2026.06.29.06.12.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:12:39 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v5 03/77] target/hexagon: use cmd_array() instead of get_id()
Date: Mon, 29 Jun 2026 06:11:18 -0700
Message-Id: <20260629131232.2487780-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
References: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEwOCBTYWx0ZWRfXz4e64H4umSWW
 QMbAx8/ehZew/8lEGRG790vc3zpKBQOgc0NGCAdrWSRGtsWRf/jiQ4giMEb0fWBJI/5Bu6+8enP
 Tr7MvqoUthR+nsEBcAFWJCp7MiZXjdqfwRhxOryA4foTFE0gzU0MhyIsQ2KR1kCv+JfklXFTLI2
 PbKEJIARW5GIuea48B54kda5lUf5nO7E1KKQUyQ16S3cH3JxIs7A+MEVAWDRe3p3hsHOzaXluKy
 G3+mVTRbuc371axtqTw9uWVH8dUWrCWxq4OlKbTEQD/IroAXr73SbaUn5wapqllk2hN8d0nvFe9
 zN/Usv7y5j/Q1lEKRTnaB+634UDL5w78MdtIMiC6mSlEKJGkvAUCUoFt2TsH3PEmFOSYB0xwLHq
 Kyr/LUuGgxXtgFsigaGc4HwUKI7wKqkuVu6KgUWvFNBtB9FJVT6FYL0W5LJwHb0X5cLzwoPO/e9
 vzehckf7+V8pdFy+kMQ==
X-Proofpoint-GUID: WPox4P_YHOjC-ogQvblRmpICh-BdAiP3
X-Proofpoint-ORIG-GUID: WPox4P_YHOjC-ogQvblRmpICh-BdAiP3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEwOCBTYWx0ZWRfXwtmwhdgolp+B
 jc1MJrca17Io1xmybTv8B04HHcx3SdGDLN6CWWOlssFkkh1bWT7r68QPJM3pFWjXxgCEtQIHaoy
 NCbIleM/L0d166Pc5ttTpaJkKtFXKnI=
X-Authority-Analysis: v=2.4 cv=OcWoyBTY c=1 sm=1 tr=0 ts=6a426f4a cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8
 a=SrZkeIdwbWuKvdoqoQQA:9 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290108
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

Z2V0X2lkKCkgcmV0dXJucyB0aGUgY29tcGlsZXIncyBzaG9ydCBuYW1lIG5vdCBhIHByb2dyYW0u
ClBhc3NpbmcgaXQgZGlyZWN0bHkgYXMgdGhlIGNvbW1hbmQgZm9yIHRoZSBpZGVmLXBhcnNlciBw
cmVwcm9jZXNzaW5nCmN1c3RvbV90YXJnZXQgaGFwcGVuZWQgdG8gd29yayBmb3IgbmF0aXZlIGdj
Yy9jbGFuZyBidWlsZHMgYnV0CmJyZWFrcyB1bmRlciBjcm9zcyBjb21waWxlcnMgc3VjaCBhcyBl
bWNjIG9yIGFueSBjY2FjaGUtd3JhcHBlZCBjb21waWxlci4KCkxpbms6IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL3FlbXUtZGV2ZWwvQ0FKU1AwUVd6UUVnb1lNQ2daWCs5akN2clY2TzNScW5BK2Rm
MURwVDJSNk1adlZYaU5nQG1haWwuZ21haWwuY29tLwpSZXZpZXdlZC1ieTogU3RlZmFuIEhham5v
Y3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgpSZXZpZXdlZC1ieTogUGhpbGlwcGUgTWF0aGlldS1E
YXVkw6kgPHBoaWxtZEBvc3MucXVhbGNvbW0uY29tPgpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91
dmllciA8cGllcnJpY2suYm91dmllckBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBC
cmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFn
b24vbWVzb24uYnVpbGQgfCA0ICsrLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vbWVzb24uYnVpbGQg
Yi90YXJnZXQvaGV4YWdvbi9tZXNvbi5idWlsZAppbmRleCBkMTY5Y2Y3MWIyZi4uZmYyMmI0ZTQ3
MDYgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL21lc29uLmJ1aWxkCisrKyBiL3RhcmdldC9o
ZXhhZ29uL21lc29uLmJ1aWxkCkBAIC0yNzAsMTMgKzI3MCwxMyBAQCBpZiBpZGVmX3BhcnNlcl9l
bmFibGVkIGFuZCAnaGV4YWdvbi1saW51eC11c2VyJyBpbiB0YXJnZXRfZGlycwogICAgICAgICBj
b21tYW5kOiBbcHl0aG9uLCBmaWxlcygnZ2VuX2lkZWZfcGFyc2VyX2Z1bmNzLnB5JyksIHNlbWFu
dGljc19nZW5lcmF0ZWQsICdAT1VUUFVUQCddLAogICAgICkKIAotICAgIGNvbXBpbGVyID0gbWVz
b24uZ2V0X2NvbXBpbGVyKCdjJykuZ2V0X2lkKCkKKyAgICBjb21waWxlciA9IG1lc29uLmdldF9j
b21waWxlcignYycpLmNtZF9hcnJheSgpCiAgICAgcHJlcHJvY2Vzc2VkX2lkZWZfcGFyc2VyX2lu
cHV0X2dlbmVyYXRlZCA9IGN1c3RvbV90YXJnZXQoCiAgICAgICAgICdpZGVmX3BhcnNlcl9pbnB1
dC5wcmVwcm9jZXNzZWQuaC5pbmMnLAogICAgICAgICBvdXRwdXQ6ICdpZGVmX3BhcnNlcl9pbnB1
dC5wcmVwcm9jZXNzZWQuaC5pbmMnLAogICAgICAgICBpbnB1dDogaWRlZl9wYXJzZXJfaW5wdXRf
Z2VuZXJhdGVkLAogICAgICAgICBkZXBlbmRfZmlsZXM6IFtpZGVmX3BhcnNlcl9kaXIgLyAnbWFj
cm9zLmguaW5jJ10sCi0gICAgICAgIGNvbW1hbmQ6IFtjb21waWxlciwgJy14JywgJ2MnLCAnLUUn
LCAnLUknLCBpZGVmX3BhcnNlcl9kaXIsICctbycsICdAT1VUUFVUQCcsICdASU5QVVRAJ10sCisg
ICAgICAgIGNvbW1hbmQ6IGNvbXBpbGVyICsgWycteCcsICdjJywgJy1FJywgJy1JJywgaWRlZl9w
YXJzZXJfZGlyLCAnLW8nLCAnQE9VVFBVVEAnLCAnQElOUFVUQCddLAogICAgICkKIAogICAgIGZs
ZXggPSBnZW5lcmF0b3IoCi0tIAoyLjM0LjEKCg==

