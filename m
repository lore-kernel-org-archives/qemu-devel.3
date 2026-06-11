Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C7ACD98CE
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:34:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXXyr-0007gq-A6; Thu, 11 Jun 2026 01:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXXyc-0007e3-H0
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:29:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXXya-0000kH-MV
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:29:14 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B5GQXT3817133
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:29:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HkjutCmYo3i/HXw/eTYFkcdwmqZY6fH2qYi/G3HdrHU=; b=Q6Noh9ymByYVJysS
 XRjmy2rNhrwLMQrAk5f68DoeXVoY4b+w9uk++Egtrl8IuexWNbIs6yLd3nfpERvK
 nVnIAhgA2SectRSjW6DQyAC9lW+Ccddgf/WNVP4nAbqowyWcLMKqv6ONxIn9CtwP
 EOaJ13cwwhbGloKeRGVfpHfy/lhnRk86AO2lFLoppp4tuyiUN9IkanbbTxMLjJBZ
 vCL2JsvXsG2i5Hx8sBXTAMeZXr5xUauGrHbcoybTtt/vRYygoSPABfrvjT08zA3J
 t/CWZsa6Kzy05Gc0GbDEBZA+l7Q9vTaQSDlNtqjtIXdH8FBhDGd8Xzl9X5DiJiam
 Pnl2fQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6usrpm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:29:11 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-308004a2c49so1573628eec.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781155751; x=1781760551; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HkjutCmYo3i/HXw/eTYFkcdwmqZY6fH2qYi/G3HdrHU=;
 b=bcomLcTnRw3E/FgTPVE9GdX9DVVtF3uEQ8BLSvAozXha5F+BdT8uAYwN8BIxz4a8QY
 BvsdEoUN4xP0tXu8ZfsDu26OHZaBgd+hCuk6afPFFDBsDphS/IOJMOCcOdv+jfyD3OSb
 pjosfIi5JVYtJyKAec8zZmzqhsPfbEvA9vReO7CUKsN1XIWIppY2JJ6/jmq/CPWNZluK
 Edyw1hg/cH+zgbU+1Z9P18UqJ2tfDoqqhEIMZyXtTjDTPZQ6fQiSttY/7aNCkzlf4frg
 ui9MZLgJa4dW+UGK+ili8cDCwqnQZmWknOuxfzNudFVIOJZTLSxvciD8ZHzeBf1OCfWd
 GbWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781155751; x=1781760551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HkjutCmYo3i/HXw/eTYFkcdwmqZY6fH2qYi/G3HdrHU=;
 b=m7eZWl0ozxfJ33YUU31cN+p3pUX4/v9NdkYEad1WJYFpl4kFAPKQDreVfcoZQvxz9q
 aC9difLa0WJmqn9S8LJ9r2cUgYhwWaQSfyrZVaRsFQ5HT0RDEbYyHFTFl0OcF3o+oTMr
 zT0fDiCgQ+nCVVpcF5aTp4ggW7r4KmU3tlw/TG5jlbi5GR2G6th+RgGA8dfUNwpIeWop
 zDCDA+bM58IkasAg4rCXko5SeG09EF6ySHpjfuBfgHL6I2rGYSrMjrp0r+iN8jchwnF+
 wa2PlfmKAg3cnmSOlaAxZFZR3tHk3vy0ydiPHw1opJhHBxWjNjGyuKbprMCB3ld4szMn
 60Dg==
X-Gm-Message-State: AOJu0Yx9I9QdQO1oMotkp+USAkcVOyihILaJV4/poEJiQiph4NvXmkaf
 v0/7RSkFgWpjvgwYCw1vBruBTPk8N3RXyXehmwnjB+3dxEzRMA/V9cBZgvNHQY033Nr34xEUNBW
 ZTL2YyZu/cu3s4gmTSKFaQguq2DlgEJ8QF2zUNtOzDm9sYpb9xqOif3Qsphk4KpeSBQ==
X-Gm-Gg: Acq92OGwNmwYFLa+ubwrgUshwO9CQNIgx8bdz+XxVCNXe6Z0Q193SZiLS/XqEa+Vp1b
 b5YaVEO2xgdtdvPw5CyPS5jfA3aWipo36hG1lO+/g+ibKptkaMsyWwKOTadBkclmJDQHGruNomu
 Kv/ZbggtWJ8kgKhj+rBlkFhi2On7GBVFaxM/JpYzdNJPfTf/LUkC0scDBnbyQkOzTwrJnyvdU/p
 486tmgUOivhlpJVYC7Lbb4onQC2qs7SJIp+woRxQdswIoZv6lW00PIPqlse5j12z6cKRGg+nrXD
 +F4DlGbDQy50mS4MV/93NRKERHj5tGFKhT0WkpE3kMhtzpOCUCiOtU6YO2k5et4s3owxhe0Nw4+
 R9A9FRT91I5VtxxogHP62Alxy/Wd1tDnIHTSkXhS1/pjx5S6TeDQg/CjoMML91YDLrIXz7fExa/
 m7HM04
X-Received: by 2002:a05:7301:4187:b0:304:4f23:68d3 with SMTP id
 5a478bee46e88-30804a143bbmr1088965eec.18.1781155750678; 
 Wed, 10 Jun 2026 22:29:10 -0700 (PDT)
X-Received: by 2002:a05:7301:4187:b0:304:4f23:68d3 with SMTP id
 5a478bee46e88-30804a143bbmr1088944eec.18.1781155750203; 
 Wed, 10 Jun 2026 22:29:10 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30806e8a402sm880475eec.17.2026.06.10.22.29.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 22:29:09 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@mailo.org, philmd@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v8] target/hexagon: Add missing A_CALL attr,
 hintjumpr to multi_cof
Date: Wed, 10 Jun 2026 22:28:25 -0700
Message-Id: <20260611052857.3911981-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611052857.3911981-1-brian.cain@oss.qualcomm.com>
References: <20260611052857.3911981-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=FJ8rAeos c=1 sm=1 tr=0 ts=6a2a47a7 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=ZLKCIdW5I75hk_SXmpcA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA1MSBTYWx0ZWRfX7DBMKdj0/V/R
 Jzvdg4Rt6zPhjBqBNsstvSlSbVcNb5eRzHeuTZIf7oooDIGUFqUjGyLhB8D+Ndij2AS5GT9RW8r
 nwzzkPd/7+kMiBHe2zgAPIrGxFt9WvM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA1MSBTYWx0ZWRfXyMREUMhLpugR
 LjBexLLIs1xqQLY+j0/VYfS0xe1QyPHsRXtR9J3q6fequEWKNlp4Gq1+ehlMYf+hyo+e9je5bal
 fUSwYsdcldd5ZohO5Mzkkf0dY6ozYDkWlxJggKdNVCaEbtwwH3/4HRVrq4/acUXQX0j837fKL4I
 SFKFpdtcwLnx0ttIl02xmqo57+J20H+OjeL/JRr2kJ9IvW7PhA8JU7/hrLJ66mpd7FywqwAblHv
 2Huwyn8mN80MO9sw3XJhKnaKy0f+tjzB9WXJrR6FvfeNoJ6yL6LfmX9YaZjWbvWb2OK27sLjt4X
 3qbJZuylTUNHC4Aj2pNoQCTeAOdlZoeQlWrx52FnYtxO/XtHjy0Dzd7m2GMVd9/hNa7Px7A0JxN
 Ppvw3y8vXGb40yvTTAqRQgVCvmTReuoOkTjYPWAwhTVz96v51GWx1mZX/4g/lEZs8GbpZrQj7DI
 3ML/FZQjxrb1VriSFpg==
X-Proofpoint-GUID: qFwq19fBHz1DVg3U9koPB3ir2cAYbsiy
X-Proofpoint-ORIG-GUID: qFwq19fBHz1DVg3U9koPB3ir2cAYbsiy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110051
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9o
ZXhfY29tbW9uLnB5IHwgNCArKystCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5weSBi
L3RhcmdldC9oZXhhZ29uL2hleF9jb21tb24ucHkKaW5kZXggZTM3ZDVhNTE0ZjAuLjI4MGFlZjBk
ZjNmIDEwMDc1NQotLS0gYS90YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5CisrKyBiL3Rhcmdl
dC9oZXhhZ29uL2hleF9jb21tb24ucHkKQEAgLTI0Nyw3ICsyNDcsOSBAQCBkZWYgbmVlZF9uZXh0
X1BDKHRhZyk6CiAKIAogZGVmIG5lZWRfcGt0X2hhc19tdWx0aV9jb2YodGFnKToKLSAgICByZXR1
cm4gIkFfQ09GIiBpbiBhdHRyaWJkaWN0W3RhZ10KKyAgICBpZiBhdHRyaWJkaWN0W3RhZ10gJiB7
IkFfSlVNUCIsICJBX0NBTEwifToKKyAgICAgICAgcmV0dXJuIHRhZyAhPSAiSjRfaGludGp1bXBy
IgorICAgIHJldHVybiBGYWxzZQogCiAKIGRlZiBuZWVkX3BrdF9uZWVkX2NvbW1pdCh0YWcpOgot
LSAKMi4zNC4xCgo=

