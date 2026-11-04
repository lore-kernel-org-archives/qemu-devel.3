Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B79B606A31B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 22:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LalGfFlo;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CvmkZk3g
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOjpO-00071t-IC; Wed, 04 Nov 2026 17:51:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xOjpM-00071U-1D
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 17:51:32 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xOjpK-0003S7-I9
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 17:51:31 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4GUZPx763880
 for <qemu-devel@nongnu.org>; Wed, 4 Nov 2026 22:51:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 T6KqzBCPXM+i/oPTmHUIz4aClryyPywLlgk53eMzZ80=; b=LalGfFloejnD7Zdq
 pehDQ/QFPUETezzY4ab7IiOZSVUqkCv4lxv6skGfb6EDVPGd+BZXtCDjxUMUOpez
 2hWOg2ArVOKuP6LwqIbBUecc3v4W5S6F7Ganatfg6Z72gOfQA6HrswC3khZHhfok
 kI6QPQANohxOvSAYqHlnevTgq7LK+b5sCgQzR72ajDTfDVhOn38WAjCs9VopCWEP
 JqbyKK1u5VOfyZhGHcKbMDrT9dxy1VWfWx8FpCuZgSKe9Omvsbt1pcJ6U3XOPGDE
 px2jc4jhBkOOSoqufq6hJ+s7ZC5O3hUWrGBseSuC6Us2y77Ca+KwDF6rbk/PoH+e
 sD58bg==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr89ssgyn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 22:51:27 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-4cc89e86e9eso1676557b6e.3
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 14:51:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793832687; cv=none;
 d=google.com; s=arc-20260327;
 b=sCOgQ4jr0+MRiBnQySpYU/mmGkaZP73QUbl5PLin2PGVHP6cVODFPsFv4uP8peMCXV
 rXwR8O2YwF9E9HlFsdFS2rXR9Dkzf/Qjb9svArQmhEbLyhvJ3DAo3RnjBSztjOMaUSuy
 awsn/tOINsqKr1+KfH+4HBqX7bbQsFntgCofA94+ThUBGv85uss2iSkBGXX9XCamvEP7
 dX1XT8gQQjXL5HAeqcYOyM0Woleo6UyzECPFastYGqtwFUOj40hXF0ZgDZXIdsNBBiJI
 fCYCJxTV+iM3mAfPPMgE9yDLfCAxL1cZUMHl//747Na5DQKQYDagV+xuLBRm0nB2lYXu
 RuPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=T6KqzBCPXM+i/oPTmHUIz4aClryyPywLlgk53eMzZ80=;
 fh=/1lq0lfR1GnA6ZK1FUVPbYmtvfdWCEexdPZ27kjzpc8=;
 b=nEgFMKGzxhzPZ9jY2SD0PvPASCfv6E6r0jHA3NaELpeK3ARLNHOuCYb04wXRL0mNjq
 4gCLLrULjPL9WGaK1fYNvKihCnyh4QS1vwi9Bqb7mruzxmxBvKkwx3rOPA+jc71/ApG4
 A05fNGzszXEKm3BQKZxYm+NgPezKqSicKQNCuKtu7QYOnQ7JigItYJIcCLUb7ckDNB5V
 zqozSiynKI1tocnXJz14rjCjmRX9jVbfYUAufc7DEk8OgwPDNDkMQFJqMiQHQC6UNbou
 qaJmdUbh8gZEdZeSCY73is85Kdm4HBTejxwYqmyIubtlnCjP6Ge+YDjCh5KS9m5MlOTY
 uijQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793832687; x=1794437487; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=T6KqzBCPXM+i/oPTmHUIz4aClryyPywLlgk53eMzZ80=;
 b=CvmkZk3gkimt6pXG2ux7Sn9mYOa38P9vxZEJNStNsQY9k1bapkJA7HtUEMPC6P0/eB
 Xrqva18UdVFAX1C2iG5HJkn/pCR+nCjS30upsHuP+tozh13mdiXDJeRlCVjBPY0bCWPr
 sYQyHIkHT8mThEa7JXPN2rh3I8EfgcEPhYxNU0nyNI6U025/Lwtdf9blnpvCw9UJl6gi
 oV4rE+L9iFp6ujLFEx+HpyRnXlndlgbmSt8FC8GyovNBPhUXL4Oz4HDoRM79frrpDrn2
 F0/nFIo8yaMG5LSjm82DokJXUZxC4gtmYv/bCjiURq5IC9Whwp74+tR6LN5ilMt7/smf
 KraQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793832687; x=1794437487;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T6KqzBCPXM+i/oPTmHUIz4aClryyPywLlgk53eMzZ80=;
 b=p/BtfWzwtMGM/CkgEMKphfKUlC0bIgrW/O7jlYH5GeZad7kvxZGxvpqBOUVGfgn6DV
 dDXILd+pfKaYtGo5pHtnjYLdTxR8gmWevggQHbhqVY6PfZt1CaNjRBz2oJ7C1904gJq5
 IkcuxUFZhX4Se2Na0r5SgZRrCpQFEuIK+1WuXlE+Oy5KxY+2fCfWM4cU9BV87K59X295
 zdkpsZyo1plbOXjCCYygEmQx7sKqd+ENOj8jYiiEwj7zED162bigmmcW2SaLoGbCpA/9
 XkcGGza41TejryRRGYqJQMKIdl4eN0iDiet1NASMTtAD3cFXLcIpBuykSl57AlDfruPv
 JrzA==
X-Gm-Message-State: APuU4Z/ZDWYJXuidzZEcYEip+K86ta+tBLPfqDLS/h+Rnm0oGTRC0kr7
 qXB00RhUG8bOB58o9w26fCB+i8Wsl6akUSvCZ5ttpUQM8MJ0e9/BzqTPgI10JaLI/HT/WBoSzIg
 zNn0DiMKuv0yiZ4eErJHC+poKYwYAB9HLZjwPc0EYudOxpG/kYZyoHfW0NiwKBjovmKQ9gPedR9
 qiRlhkH56klxTUFLAedBhay7qA5xtj8OmZ/Oqu8nyrDR8=
X-Gm-Gg: AYBFou3d3+NggwAliFs3edtvnqOjqY8X6S3ie2rpfswBJ2jOqNPvyWZ0sprESmortpy
 WF1Bpk84A/AnubkhXeVigRZdBEeUNDC2cooDZ3o3Gc3IfwHJ9vAq0LlaK7QUskE6iQxnr6RZHtT
 XEzrl9Jbz0wv3YmLXMecl6UrVm3zUQPXy5tnrRidFUUed8nTGCvH0KwI3nUQ0lwLeQnPh3CBrdM
 TcLL/NDYEXviZYJ2Q==
X-Received: by 2002:a05:6808:bcc:b0:55b:f929:60b0 with SMTP id
 5614622812f47-5640df1c59amr13655834b6e.59.1793832687091; 
 Wed, 04 Nov 2026 14:51:27 -0800 (PST)
X-Received: by 2002:a05:6808:bcc:b0:55b:f929:60b0 with SMTP id
 5614622812f47-5640df1c59amr13655819b6e.59.1793832686611; Wed, 04 Nov 2026
 14:51:26 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261103192358.28589-1-anjo@rev.ng>
 <20261103192358.28589-4-anjo@rev.ng>
In-Reply-To: <20261103192358.28589-4-anjo@rev.ng>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Wed, 4 Nov 2026 16:51:15 -0600
X-Gm-Features: AclHuK-r_NSJEJs0MkmV1HHrIPNaIK-5vbAd9pQOLNCShO_l6gd-9QZ-FsgwJz4
Message-ID: <CAJ+KCYOiTLRQnGg39uEMdPOb5g7j42TbdS2aPTc3skZGWNb0Kw@mail.gmail.com>
Subject: Re: [PATCH v1 3/6] target/hexagon: Forward return address to HLX
 load/store helpers
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, ale@rev.ng, brian.cain@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 97QqSnINkkRlicfwkQnF0xgVa92JzTr7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA5MCBTYWx0ZWRfX9BH5PqZjkpUN
 1bEzUCenu73SdIq5L210lH2jVuyMiaeah4fLpHf5qo4zulB3kiy1Dj3AlOHET84vs76wsqEtw5j
 5nhktQIWLgbFTBJIp1AzYoPDeOyHavAo/tYUEFHYi9GWX/CzY13CJyfFWI/Exym3aNgHimQadRw
 TPJDBAZdfkekJmbUyX/TU0iI5NXMzdg3Pda398B597w7jX/yp/SlRyASGJhMJhkWqcaMrBnWx1H
 aj9enEBWs4+hrwRCpo7AI74lE6AcBV0fU89izrFk7rm5+PNUvC1ryUQe+q1TNSM8sm8HQqbPPmt
 hCd9v6FeyuB2sZMB504NXHUOYBZd4igIspYkp21y4bNlBKx44ut46l5rKlhFp5SUu+uUk+PwSM0
 Eau/XANtzsQ7XBoi3pNSAeWNSHY0R9Ul4cnUBhpAFfi/I0g3F/O06IwH3g6jsD7MxeXUwRa5qHo
 Raef816saj3N78hZCTA==
X-Authority-Analysis: v=2.4 cv=N628hG9B c=1 sm=1 tr=0 ts=6aebb6ef cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=4T5XvwpHbLauLer8zt4A:9 a=QEXdDO2ut3YA:10
 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-GUID: 97QqSnINkkRlicfwkQnF0xgVa92JzTr7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA5MCBTYWx0ZWRfX9ov5cEyEuRyB
 BJypen1QgrH7puNDtZiOBCnp4KO4BusRpJyJuKTrCY2Ak9zMpjbTpMeKknAOKB6zRJvZc9eWoIP
 Tm6HxUCb42ccgd/8H6DNsuXZ4e8qDIE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040090
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=marco.liebel@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 3, 2026 at 1:18=E2=80=AFPM Anton Johansson <anjo@rev.ng> wrote:
>

Could you add a commit message body which explains what this fix is for?

> Fixes: 2db29a3615a5ad2a3 ("target/hexagon: add HLX helper support")
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>  target/hexagon/macros.h     | 13 +++++++++----
>  target/hexagon/hlx_helper.c | 31 ++++++++++++++++++++++---------
>  2 files changed, 31 insertions(+), 13 deletions(-)
>
> diff --git a/target/hexagon/macros.h b/target/hexagon/macros.h
> index 2748e26d6c..5799016ea4 100644
> --- a/target/hexagon/macros.h
> +++ b/target/hexagon/macros.h
> @@ -22,6 +22,7 @@
>  #include "hex_regs.h"
>  #include "reg_fields.h"
>  #include "accel/tcg/getpc.h"
> +#include "hlx_helper.h"

hlx_helper.h is missing, so this commit (/series) doesn't build.

[...]

Does it make sense to write a test for this? How did you find it?

