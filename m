Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B75F3F36C58
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 12:10:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEnSL-00065u-2y; Mon, 20 Apr 2026 08:10:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wEnSA-00065S-Vk
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 08:10:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wEnS9-0004LF-3L
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 08:10:14 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63K97pkL1599858
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 12:10:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=aKiqCQ7/i44
 kdIbKxqFJjKkfYnM4ft1kAt5KZHJh+QI=; b=pIoI/XG3WBsn6g09DJujIT9x1/8
 rcBdOZdDoggsRw3s4VRrQw0Y47QR1sV98ef5o4uguvzUMfc9ibpVK5qLfmAN8Il4
 I+ns7+zRU0cWvT++YEKpSJ8Ng5b7mvhb8lkq6KlzVsnCIxONi5zVOdNgdS4drJr/
 YVDTYFtxO//qginCKLiI/6BEcQXr0vo/Q7vIUmUESYmmx5iEgy1yui8CmLroeQz2
 7x54EyHwoO0//LbSQaJ+zR1aSJ8uQeeMFKNw6y64c0LfKPWeGRo9U5CueOqy1zn9
 HbmQDi9u0XR7vb5d3lfAvoBSE46MXhiH+YANeG+kFMDbSHlfHJgKA35Veaw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnh898kc1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 12:10:11 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2de07c12745so4929657eec.1
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 05:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776687010; x=1777291810; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aKiqCQ7/i44kdIbKxqFJjKkfYnM4ft1kAt5KZHJh+QI=;
 b=hxtl5RI9x3wwWs7hVo46fVXQguwdNdJ9krrn/SDQZCpqOP7cEtYHjI6IhcM+vseyM2
 HrFzzYD07ojKj4+fO/4VM9r8KN7Hdj4zRoC/n8jikSp9ndmAgMf1hBvc586CQO3uVqmU
 tmX8fJVZ6NyxnfGyRBoBkcJNUYgXvTuILd1W0cdK98/4ilzDuKEs2aXKaS0+o8XX70l4
 M0ItYXebhpZBoA/i8kujG8cRD7fWIXYFVEEGWgnhbZMXwc1BYLAay6HpGO4OEJFef1yi
 rHS3vkhOHkqtTvnXbldgQNxVMLz0SoAWEeoT2XssaUVGv3uXnVwqmYgKXrIly8R+i1JJ
 tlwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776687010; x=1777291810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aKiqCQ7/i44kdIbKxqFJjKkfYnM4ft1kAt5KZHJh+QI=;
 b=miXj7txD3UB6W+tSZgZc0Du7cIKqp7DctnpIyYpSi1NgXtmI2//bN6equJv57rSjxI
 Uusf5JkO/Vnp7QC3FRSplUBmtcPjZMQABG535flTNWbCp84vtodaRxnu/Bqn9LVYckD7
 ioamrWrWp6ME+WRuZCliq375G7KSrou9+Nf/OgTCxvjyHQXIhB+iCOueM8mx70DoV7gq
 ZXqlPvVJpIGcSYQFB1qOgtHxFNFSuUPs2YhL2uJsj4VM9Fdi8pXJrs3+REnHIMFNcZi3
 ZES8RD1Oq9Ql+wBabJGAXlNxS1blJg7ZFP5hwbyUoxCP9hP6x5Wr3lsV2EyzMggEkBu6
 SdCg==
X-Gm-Message-State: AOJu0YysNbaSf2BWo3x8UqS57uxTrF5Ypj2Msm/7dhTpL4k5zaBAYcvi
 pnSdGQSjvDhRq6ZveNR59YlpHSHMfSAk4z5sLre3UN13M78T4aa5QLg4hCNuqn0UwtfzfwEu1GM
 epwY/W1z7WvUhyOtYMnVk/dGLz63JqKIhTdscblwFxgPDyj+SsIwBztTx80lGXYOuzsEw
X-Gm-Gg: AeBDiesLiOD9jmUPLVyf2hwsXLA2CnqxtwEMpIbiu6+fR9/hhD6YB3czagAAFnRZZRg
 n5lpV4Z/ZKu8f6sX5UPd5UC8K0L4hRzX1JMowVsP/Tfd71qokbJnSp7M2VnKxO9Csvkn2GHJbOg
 Ji+e8R25FZ0I28mL0U1o7/ruMndhCLUfDU1FNTR+YfoxoIMYEihIfGLHrovDBkAb4Fhjx3J3Xq2
 ObPBocwuDA1E9WDIDjJyIAg6oUnUdCWWuwBuQHhrGEjFWnh0DQiIDdT8KyZxbQwF1a9FL49N5Uq
 mT5D2BQGx/tupu6Wj62J3sDT4JIR6iyERdTFLtNTaSpeNd7uJi9flUXZF6H1aNbHhnxRGYwI2yr
 X63BzL52Vl/yd1/BqKyGs5LLhcAyxycyVV+9o3oynt/OgSii6RQzhUy6qfn182j7Sw17MFhtCAF
 FLhJ7oIN+Yd2AvL+Ezfzo=
X-Received: by 2002:a05:7300:7491:b0:2d9:32c8:2b69 with SMTP id
 5a478bee46e88-2e4874e7a8fmr7808085eec.28.1776687010156; 
 Mon, 20 Apr 2026 05:10:10 -0700 (PDT)
X-Received: by 2002:a05:7300:7491:b0:2d9:32c8:2b69 with SMTP id
 5a478bee46e88-2e4874e7a8fmr7808049eec.28.1776687009343; 
 Mon, 20 Apr 2026 05:10:09 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e53ac84c38sm14439594eec.13.2026.04.20.05.10.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 05:10:08 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: pierrick.bouvier@oss.qualcomm.com
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com
Subject: Re: [PATCH 2/2] target/hexagon/meson.build: simplify source generation
Date: Mon, 20 Apr 2026 05:10:06 -0700
Message-Id: <20260420121006.985611-1-matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20260417194606.39997-3-pierrick.bouvier@oss.qualcomm.com>
References: <20260417194606.39997-3-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDExOCBTYWx0ZWRfXw67ntEvS87M7
 1AviG4eGOZjkbxWjwf3KfJVsvOWDXhmh5j01qmVyZZMZVzkxh4bsZvB6bx2jScDWiy80G4+Trml
 IfuYeSb/9wlUs85WbTBGU84Q3ATmsY2p6BLms2pTz3mqRKhvM1BcKIWntWhuLRG7VsneK9MsYdz
 6RNaNGMeajiYjUz5D62dN839i1ptwqwiDycpUyr16PqiEYAQ07CDgDemrO2v3mH6R7pSLQlOI7n
 siBUB7haUoNPWT3CXPl1hLRYY7gijH0ZAgP2BptTGy73zK/+HvtQQHO9e2uvCIvyf6iFf8sjCve
 YVtxDkx2r93ByfzuUrooIzCKtlswra4SD1dDg3uytPBi28ufZz4rpGFWIGZRrqJcE28jDbkx5Mj
 PK0MdnhJPmpdag5kJToTKZbWZkWfOTEanKUBWOz6FDrKjr4eHDtPD7ynVHT8YF9V7yCtgLW3oAp
 Y5LBqkUz/NbTyrokp/Q==
X-Authority-Analysis: v=2.4 cv=D6B37PRj c=1 sm=1 tr=0 ts=69e617a3 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=GawJeYPMZVpLNvE_ZWEA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: WkQZ2vRNCw4VZ9vKpKXs3eX1WC0HfT0C
X-Proofpoint-GUID: WkQZ2vRNCw4VZ9vKpKXs3eX1WC0HfT0C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200118
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
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

On Fri, 17 Apr 2026 12:46:06 -0700 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
>
> Use a for loop with a dictionary instead of repeating custom targets.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Reviewed-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com> 

