Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB64CD37AC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 19:58:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNcBy-0003zf-4f; Thu, 14 May 2026 15:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNcBv-0003zJ-AI
 for qemu-devel@nongnu.org; Thu, 14 May 2026 15:57:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNcBs-0003ud-UQ
 for qemu-devel@nongnu.org; Thu, 14 May 2026 15:57:54 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64EIpSPG1847980
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 19:57:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3K5c7/FQpJEVuFLWRYpfSN7baQ+Ib6ov4gnEkzmfwwM=; b=YFmZz1XwxGEZi22O
 Y8jn292ZO60vcDIh4778ft6BF2yAxP+FaaDtSrJ3zpR+ZfiK77mlnrW7WNJUgT4G
 gkvtg+otTOenIT+ogXMpcBmNUyUPkHiRv54jZeucSpidmym8gyUbME1CV5njYif+
 eM5zdBpgXlXZj1TnMbnGotEYYq6Jf9GcgrLRLyA1C6U/x04Pp/gHXT8qx7DJ3rfB
 AyRS6U14Vlg/QxQG4/k/r0Sbm7xMNI5dNojnEq2JbUF03wopSq4CNq/DZnIYIh+S
 cGRCkgQ9+k9CTATgqhYQENSm1rgFq5+lKHSqeJVbksIhndIPWu8rLyUK166N/6ix
 97HI/w==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1t06j2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 19:57:51 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2ee34588671so11224525eec.0
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 12:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778788671; x=1779393471; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3K5c7/FQpJEVuFLWRYpfSN7baQ+Ib6ov4gnEkzmfwwM=;
 b=flayEGE3GkfkvsbekBJJniwCLcvYzqLkyTl9MfSiAi+U2wf5BWU9SbY51OHqSurZ/q
 r8NMnZKtZyqljDO+hJD+FNlpkzQ0KJe2WlcvtFtW9veW0Atb83wyeORD+2rF4UeiqZTt
 a/6jD7fOZRbBmp20TApIr5RXNORt59fMJfHpRWgtVXxSXHJBSy6yQu2+7MrTbmPxGM7V
 FLbyZ3ii7MN5SWsSI9Ex+XMWNDeqvm3TXHhzHQBMTj+JxUwTyrXWXq3JV2mwAQ5pdBJk
 iB8QvEnCYOBFpy0Dcdd9CMHxmLLPBoP8rFqvhgH3KYdaXuNjzeG9Z9QHLgnQne2F2uaR
 VW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778788671; x=1779393471;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3K5c7/FQpJEVuFLWRYpfSN7baQ+Ib6ov4gnEkzmfwwM=;
 b=NPVb4RIVl9Qxi8gY4HgJHwnSe5mjusJO+88rUDKa0Spx0znDYx54Y92wNNZOOT6r9y
 K1PcjK59k4NMDuMYTkhZVjsISfXZX5LmC5vth3AhlKlpKVCA/DHIG2j9bvKqoYB6T5o6
 8xXExLrBVRmldZSFe4VG5PArSQgFV4oj6z9Z6ByvaA+VkKixTnch/K0VgsIoQeUpqyzK
 NayTN6xLe19BogiKXhqNYi7P+AVMIjOu4pzdvDgOkisRx/zjCwNR3in9lE3rGIa2TRKG
 4NNyrhSPtCLBUpK/wv8Xi67UUODo8FhBwIqrR/S3cYH78NHBUJRv6p0smizIrMgQLmvb
 zq2Q==
X-Gm-Message-State: AOJu0Yy+j9SVXK6eOslSRansZw18Jrv51aX2ok8M+s87YnXhq4h20EFf
 4qK2stf6GQ+k/WhuGED7WYeuplI37ALOtzl/MS8t4lEizaSzexA4r0vC6kIsSxyoreZhjU/p4oN
 J8dFK6xNf+iC1jlkiPJcnNtbB3B44HOyAHvRjbaDwdylCrBttsgO6hFA7If89FsnmlhCN
X-Gm-Gg: Acq92OED+V2xSooFJ4DxIU9ghloTEYLVlM+uqAe16LJ/7yILpYqFb9dUQ+glSMoKz0Q
 hmxluLIpTRdzIHGEpWhz/LPX81CySFy5ufFwRLPUALuBP92J2K13fR1/lrKEV1bh7Mbi4Lm3rIn
 Gr8VHuOAd1EIpLtc5hHOC3bFSI39E0W7wYjMNlNzWyAWQShGNfewY/VGK94qkIdWBcAzXXXiYiT
 9t3Ox3MoufomhCG2dynOcXGrsHsstbezynNWq5JEaW9yX2YCoX1xKsClG1yT1z8cmJpBflsQWHG
 fLWdhRkhxsUgo2ZNU7jLlNCVtamk2/q/vmYhoednOrpURE00ca74qmuzGRdcA1N7dYdAxijv78J
 DV+K2nGcYZv4pAQqrKm2XnO+WPbenxMoYj6CgPKDEJ1V2zpgJKIjuLBH1Qu3fiD9JLxBDQP2bou
 5TWde+7iP2OgFb3Q==
X-Received: by 2002:a05:7301:600c:b0:2dd:6937:79d5 with SMTP id
 5a478bee46e88-303982b788dmr509571eec.8.1778788670593; 
 Thu, 14 May 2026 12:57:50 -0700 (PDT)
X-Received: by 2002:a05:7301:600c:b0:2dd:6937:79d5 with SMTP id
 5a478bee46e88-303982b788dmr509550eec.8.1778788670074; 
 Thu, 14 May 2026 12:57:50 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30293e2e6a9sm4268045eec.2.2026.05.14.12.57.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 May 2026 12:57:49 -0700 (PDT)
Message-ID: <e6baa141-2518-4035-86c7-698c02ca9049@oss.qualcomm.com>
Date: Thu, 14 May 2026 12:57:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/5] Target-info update for 2026-05-14
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
References: <20260514195427.1706609-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260514195427.1706609-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=D7Z37PRj c=1 sm=1 tr=0 ts=6a06293f cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=nN85XAwELvHt47h4tdYA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE5NyBTYWx0ZWRfXz+0S2/EfjWZP
 Up2dlzPsrVagF0CcuPtNwxaqLcmqy+OBn6pPCun8gqvlgVmUYBSfMMr3TyCKl1pHP/AQVNkObNu
 pNaTrkN025KGIUMOJEzowTmu7iVyJz+8hxQLEJrqCrxw12bCLB3MkqEerKxWiR3zCJqjhPmgUik
 qfXg7T3MdUvLusmHdlssDVAQULLAxRDUONY2NaLWbxWwYuXFjdAJqTJ0yJGq2CMy2O8yY/COeZ6
 Wdti0AvvJ4Q4hIqe7ZorwDjXUTsXjXeoQJM0XDIgcIayDYBmBgFuCj0EOAWyKcC4i9lmxnGlJRN
 OF8aLJFFeyPUm3sYxtm2Ezk+TI6MboIj6zCeD35fDQeQE69HGHldzdDMUI4vjD/78suVrqUd9Z9
 S7s6ntvyGQjNWXAGIFTf5qdeCcKTLobOVhP1RxhcDt7uj7KxSa3rKWGJ5MVG5zMyFRUXdrT95Vj
 3dFADQM/HI+Q6YYxj2Q==
X-Proofpoint-ORIG-GUID: A2Q5bC8vG5Sfd6QSlKSB1GiNJeHjdBjg
X-Proofpoint-GUID: A2Q5bC8vG5Sfd6QSlKSB1GiNJeHjdBjg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_05,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605140197
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 5/14/2026 12:54 PM, Pierrick Bouvier wrote:
> The following changes since commit edcc429e9e41a8e0e415dcdab6aa52ad17ef8889:
> 
>   Merge tag 'pbouvier/pr/docs-20260513' of https://gitlab.com/p-b-o/qemu into staging (2026-05-14 10:18:06 -0400)
> 
> are available in the Git repository at:
> 
>   https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/target_info-20260514
> 
> for you to fetch changes up to 669f866946289ec783b526924aa91f7847b0551e:
> 
>   target-info: replace target_info() in system-mode (2026-05-14 10:41:17 -0700)
> 
> ----------------------------------------------------------------
> Changes:
> - [PATCH v7 0/5] single-binary: deduplicate target_info() (Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>)
>   Link: https://lore.kernel.org/qemu-devel/20260514172303.1484273-1-pierrick.bouvier@oss.qualcomm.com
> 
> ----------------------------------------------------------------
> Pierrick Bouvier (5):
>       qom/object: register OBJECT and INTERFACE QOM types before main
>       qom/object: initialize type_table in static ctor with fundamental QOM types
>       target-info: introduce TargetInfo in QOM
>       target-info-qom: detect target from QOM
>       target-info: replace target_info() in system-mode
> 
>  configs/targets/aarch64-softmmu.c |  6 ++---
>  configs/targets/arm-softmmu.c     |  6 ++---
>  include/qemu/module.h             |  1 +
>  include/qemu/target-info-init.h   | 53 +++++++++++++++++++++++++++++++++++++++
>  include/qemu/target-info-qom.h    | 30 ++++++++++++++++++++++
>  qom/object.c                      | 22 +++++-----------
>  system/vl.c                       |  4 +++
>  target-info-qom.c                 | 45 +++++++++++++++++++++++++++++++++
>  target-info-stub.c                |  6 ++---
>  tests/qtest/fuzz/fuzz.c           |  3 +++
>  10 files changed, 148 insertions(+), 28 deletions(-)
>  create mode 100644 include/qemu/target-info-init.h
>  create mode 100644 include/qemu/target-info-qom.h

This is a v2 for:
https://lore.kernel.org/qemu-devel/20260512183030.1431103-1-pierrick.bouvier@oss.qualcomm.com/

Regards,
Pierrick

