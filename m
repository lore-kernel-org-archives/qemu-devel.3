Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B3AC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 15:23:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sChbj-0001nv-0f; Thu, 30 May 2024 11:22:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1sChbf-0001nC-Lb
 for qemu-devel@nongnu.org; Thu, 30 May 2024 11:22:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1sChbd-0007nm-GO
 for qemu-devel@nongnu.org; Thu, 30 May 2024 11:22:19 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44UF8eHD015761;
 Thu, 30 May 2024 15:22:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8wBQoSeHQ/uWBQvYi62os4eR33jZjLqvUh8BvP3N9os=; b=Oq6k44OSbMmNO6sS
 bheJ9gfLetoZfzCxr8u7ujVgWv+39rDgnH/GEYLdY6m5SdTzJDDH40ZHNV642+V/
 1MmzEG7wtdSJ0gmtK5kkXeeD3FKOIQtEdhhyWSgnwsTXh7egp89T7Shf91mUvYkk
 cNyb24A2SLkjNAzIm21ut9VRa1SnIn9IYYT0KnOGg26WxO2FAWy7ZnRFFu5ejYz2
 7OKsyivfnErDVED3GXULUkNuxUC0OP3GA440DALUIZT05AeK2E4YTtrNaBnEwT0l
 oSFVbWQoOReYzBkM9+LNO6fS3paWJZum2gPZQqZMTWLgfevYFneIwY+HqBibbZjN
 PwbXMA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ydyws429d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 May 2024 15:22:11 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44UFMArW015711
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 May 2024 15:22:10 GMT
Received: from [10.222.168.90] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 30 May
 2024 08:22:09 -0700
Message-ID: <e6bfd903-566e-4e1d-aeaf-efc798b36a92@quicinc.com>
Date: Thu, 30 May 2024 10:22:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Semihosting Tests PATCH v2 1/3] .editorconfig: add code
 conventions for tooling
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Maydell
 <peter.maydell@linaro.org>
CC: <qemu-devel@nongnu.org>
References: <20240530112332.1439238-1-alex.bennee@linaro.org>
 <20240530112332.1439238-2-alex.bennee@linaro.org>
Content-Language: en-US
From: Brian Cain <quic_bcain@quicinc.com>
In-Reply-To: <20240530112332.1439238-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: YTw2JVKbwEDHxS4n3SWZ6ZXRXm98Hmn6
X-Proofpoint-GUID: YTw2JVKbwEDHxS4n3SWZ6ZXRXm98Hmn6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_11,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405300116
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_bcain@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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


On 5/30/2024 6:23 AM, Alex Bennée wrote:
> It's a pain when you come back to a code base you haven't touched in a
> while and realise whatever indent settings you were using having
> carried over. Add an editorconfig and be done with it.
>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>


Adding an editorconfig seems like a great idea IMO.  But I wonder - will 
it result in unintentional additional changes when saving a file that 
contains baseline non-conformance?

Related: would a .clang-format file also be useful? git-clang-format can 
be used to apply formatting changes only on the code that's been changed.

Also: should we consider excluding any exceptional files that we don't 
expect to conform?


> ---
> v2
>    - drop mention of custom major modes (not needed here)
>    - include section for assembly
> ---
>   .editorconfig | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
>   create mode 100644 .editorconfig
>
> diff --git a/.editorconfig b/.editorconfig
> new file mode 100644
> index 0000000..c72a55c
> --- /dev/null
> +++ b/.editorconfig
> @@ -0,0 +1,29 @@
> +# EditorConfig is a file format and collection of text editor plugins
> +# for maintaining consistent coding styles between different editors
> +# and IDEs. Most popular editors support this either natively or via
> +# plugin.
> +#
> +# Check https://editorconfig.org for details.
> +#
> +
> +root = true
> +
> +[*]
> +end_of_line = lf
> +insert_final_newline = true
> +charset = utf-8
> +
> +[Makefile*]
> +indent_style = tab
> +indent_size = 8
> +emacs_mode = makefile
> +
> +[*.{c,h}]
> +indent_style = space
> +indent_size = 4
> +emacs_mode = c
> +
> +[*.{s,S}]
> +indent_style = tab
> +indent_size = 8
> +emacs_mode = asm

