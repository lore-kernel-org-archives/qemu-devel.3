Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE0DC624DE
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 18:57:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Cc4-0000Yx-7M; Thu, 03 Sep 2026 14:56:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2Cc2-0000YA-FS
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 14:56:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2Cc0-0000YM-S8
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 14:56:38 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683G39Bu927762
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 18:56:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=lCmFYWpR3bgB80nTpCNoUTsHi7Z1z1na67n5WzKmEWo=; b=P3
 CqdTgwtMTusXAoTHGQmlLBV0x33Pdjot6+tZQ17Md2xymLv4UgVSvLUAkWxy1jT9
 I8aTGkE7z0+3vLHGlzy7ca3PYdQ5JmO3nP5Oigj7oHupl2ofMQMD4hmvwwf/EFVZ
 IztF9t2+fjnnM9lqUxarH0ADNe7RSFofo2Bo1cxIh8BMWDs34ZzB4CigKQ8YJNQ3
 R2nTpRjTl1HSkT7YoSBCsU4LS5U/YfOIZHhrLbcbxow3DXuvrtelSdx5C84bOLMp
 Ujhjx9hSAOmVF44r7zV0NHJBf/UprOUxBqpXCh1MtN8KA2dOwv2Tf8LyZbdJxmcb
 ow4XQVqGFdPiWIAseP9w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf6tx2c4h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 18:56:34 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-39512608fb1so268288a91.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 11:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788461793; x=1789066593; darn=nongnu.org;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=lCmFYWpR3bgB80nTpCNoUTsHi7Z1z1na67n5WzKmEWo=;
 b=DnWVUJ1tZZB0hTuHoO0gTROsWehDrdRgynTXvgW2F6o+LJdGCTok5e7uVxL7zvjtee
 /WH0uLFXdXOinKepg5vnEebDEIde3LjzukUgyaYTt7NS0ZYwLtF6ZDwwD6ZkPvvUSftn
 ZV8NcHX92mDLwJlIFSURPBGO9OqVG0h86YbK6BGvuXqhrZGW9m2/Y9C3R0BS3OrcBvUn
 zbs6m9fBmGo3uPyHeMuljMIRv4lt8LoR4db+q5NJyfNeKQ8educRgIqBrHclQTFzOSG0
 Jwbsm97AokW1FUjYOqobJaW7TKsc1Zio31IpKpfuMABRWzDsSvGad6ry2dtpw4LEYqpG
 wx+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788461793; x=1789066593;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lCmFYWpR3bgB80nTpCNoUTsHi7Z1z1na67n5WzKmEWo=;
 b=WZ2BBi4yfCGcmkWWqXztwic5WlrUxkbyhiS8gP7E8fvLpnS7Z+W/mEnQGI/XvNuy8m
 J6bRixtqSQMObHaCoXlRzDZy8a/fw6Iw71QsQIOel3je8VyKG8FmDqatRAkn6sSfwJ7D
 dap5ahlPNCVBUcrgkUAqQP12DIpL4X9vlOUAzVYaZcmj9L18DkhY72fFV3lZibArI8KV
 7vZ3CZ6lmUUROYtjH1Rqy+bZ5oz6jJIT0498tI5SzKRnszJRos/RWY+P6T3EtJyDrcZI
 QH8wUrgPM2iGZdl+zCSVEi/7PlqGpJvFazxjjOX6Z1T13nu8Ybt19XKNDWcyOKL0M8Mq
 X7tQ==
X-Gm-Message-State: AFuF++lAzqMn1asEA9LTx5hZpRFcuO6xXMN/m/SLds8ZNARKy6qS+5Gh
 S9aHGAjIXhoOJgXJ7xnDD3sbZU9yGKWwY7nFo1/cjXRgKw5cM+TDQjABvQxMnDfHpoqH5INgZhK
 Tn72lVBSFjGMXTajnYJgpKuDW8+Z0oXKzii+IyQd7MQPyGaNKRFtR4g/YLOMnu9ZVNg==
X-Gm-Gg: AYBFou0eXdO9igGmCPPXArLod0M3zZAfAhu2uQCx4Ltq+tfiZsaETaWSDLSDDkSp5HQ
 snChWABypJTY9OuHzlFT9XmAkMXWhDougccHo5sjAF3VavjTBu7aicW7KV2T6dPwpiiohiTH/fp
 4dfVZSKDuAI8T0mPSJBAqz0D2EN7LdKsqO7c2kWzUC47owZqOdNoRD6PNIwMSvINW+jgR47jgsX
 YbacojBx7HfKYO97La5+/JkrDOYtwqlY6KdBauku4xDZh29o/iY3IAMbbdJobnNAc+6Qb4BOLCx
 ynzbQsSBxJAIBaesxVkOnUK7gNBY1d5Oslip+O8H8Nda5BOrSlfYMAB4d8CKxZf61Y0nudjxjOy
 Kbq4HSFRoKp8N8bqBoYWLf7c+3+7mx4Y6COQbuHUV8riN2Qch
X-Received: by 2002:a17:90b:2e0e:b0:398:9be5:b419 with SMTP id
 98e67ed59e1d1-39b2622bfecmr889966a91.20.1788461793164; 
 Thu, 03 Sep 2026 11:56:33 -0700 (PDT)
X-Received: by 2002:a17:90b:2e0e:b0:398:9be5:b419 with SMTP id
 98e67ed59e1d1-39b2622bfecmr889899a91.20.1788461792709; 
 Thu, 03 Sep 2026 11:56:32 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339c0ec914sm922974eec.31.2026.09.03.11.56.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 11:56:30 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 5/8] target/hexagon: assert guest register pair alignment
Date: Thu,  3 Sep 2026 11:56:19 -0700
Message-Id: <20260903185622.3234171-6-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260903185622.3234171-1-brian.cain@oss.qualcomm.com>
References: <20260903185622.3234171-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: Mz1VNN38UlnGUkpUX9ZzOSquEP9h-p_T
X-Authority-Analysis: v=2.4 cv=TqjWQjXh c=1 sm=1 tr=0 ts=6a99c2e2 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=IRiCDiS4x8IJ1kWjObwA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: Mz1VNN38UlnGUkpUX9ZzOSquEP9h-p_T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE2NSBTYWx0ZWRfX6l26VQNhHPv1
 AF0R4E7KBEntjx+iZHisH1NqqN/ullir0lrmWQCYGmY2OvdQtePZlILXYzESueFAwJBUpLTzPHR
 e7drB3V8eMB5xl9DyJ4+w7O7HFtNLr806Je3+zYvImzT599IfKO03Eb3a3UyCPaM6oPMOf8ki8O
 U7ZjDPoqHLJPWVwZ+xx2ZVjgqYqqRiEJowsPGa8488tPQ7SJHWZvxPFXG1C/L5wauQyWRuXnJSq
 wGWxCakMiPJVrQOIOpGwfVPgFXltQukmADU0kq955lE9oxAT9nOqiB2MVIMTzSJ8J0XreNv6oOV
 3jMoZu+CDwxccip2cuNBs6Qu141IHWOd4Yy+wHImqEFSNwTslDmx0ysAVRSbgrYUi8AanBxGAVK
 0xxPNYhfL7Hk+cx9UOJM7TLixwEtbRoSGmctsrNwHFNeu5IA9QRhYtQ+nLrPfZjzHEHxKFwYG4I
 ypd4aIm7dAn/cd/Pt+g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE2NSBTYWx0ZWRfX8CDIHitck8Bq
 8F/wiCA18Xj0uXd/0QJG2wr3DWCE4x9lUU/qoAieHqsYKdgoqbszblNxWngn+bgWTv+SV85AsN0
 DLUawRkP/R4Oexw9CneE71OpADhOfeo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030165
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

TGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC9mN2YzNGE0My1jMWNjLTRk
ZDgtYTg1OS05YWI3MmUxYjAxNWZAb3NzLnF1YWxjb21tLmNvbS8KU3VnZ2VzdGVkLWJ5OiBQaGls
aXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYt
Ynk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQv
aGV4YWdvbi9vcF9oZWxwZXIuYyB8IDIgKysKIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KykKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyBiL3RhcmdldC9oZXhh
Z29uL29wX2hlbHBlci5jCmluZGV4IDVkNjRjNTUyM2JiLi43YWQ5OWNlZDdhYiAxMDA2NDQKLS0t
IGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVs
cGVyLmMKQEAgLTE5MjcsNiArMTkyNyw4IEBAIHVpbnQzMl90IEhFTFBFUihncmVnX3JlYWQpKENQ
VUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCByZWcpCiB1aW50NjRfdCBIRUxQRVIoZ3JlZ19y
ZWFkX3BhaXIpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCByZWcpCiAKIHsKKyAgICBn
X2Fzc2VydCgocmVnICYgMSkgPT0gMCk7CisKICAgICBpZiAocmVnID09IEhFWF9HUkVHX0cwIHx8
IHJlZyA9PSBIRVhfR1JFR19HMikgewogICAgICAgICByZXR1cm4gKHVpbnQ2NF90KShlbnYtPmdy
ZWdbcmVnXSkgfAogICAgICAgICAgICAgICAgKCgodWludDY0X3QpKGVudi0+Z3JlZ1tyZWcgKyAx
XSkpIDw8IDMyKTsKLS0gCjIuMzQuMQoK

