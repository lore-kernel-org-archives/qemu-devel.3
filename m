Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB79FC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 17:55:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjKs4-0007j3-5a; Mon, 13 Jul 2026 13:55:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjKs3-0007iR-3T
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 13:55:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjKs1-0004kb-Du
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 13:55:10 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DF8Hqs1709145
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 17:55:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 z5F6qhZy26LrnEk8MegQW5F/7zIuhTT+D8ungh1IuV4=; b=ViNo0o6FlOiAuc5r
 mPEFWZmWPCUKgQrl/xWMgE3Nd+lO2pAH7hvb7btP8VDuDc5DhHKEKAmvm8ZaCpCd
 xHInmf5n4c26f7vmJgHE5m7FhZ8ynWS44sr7Z2NWjoU3IGLVrXP+wD1Xc4N38kx/
 sQKEPQb022DsJ2ow/GmwRhQ6kSWjfLb/1qdbH8I30OzvbpU4t32oAiqZq/G25+WQ
 mmmOBJ94tHd84PfeVlmWc11K7sKDPE3equzaHb3p2W3V3tpeZDhfJ01+Knyf7Pip
 h2iVvn1SpLtLvGAN9TEy9c6pUStAKIcRn10Lee+dewz35PE2MlYs278vzmtlTPf4
 D2jDnA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwk9syam-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 17:55:07 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c892143db7fso85559a12.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 10:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783965307; x=1784570107; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=z5F6qhZy26LrnEk8MegQW5F/7zIuhTT+D8ungh1IuV4=;
 b=c8ZGVJG07ydsEU/+6WqZQaK4t2aXitmNW1JYy0vDoHRYQVbIz7VkXScGVcDofq43Dk
 63p98I52ZDnm5mLIxr6lxJqvywKH1UBc8zpG5wUL8kSN9zYVmF4f43Nsho+QXHwK24td
 smsOe6NQNe/QT/VvVrYZVmTnBQiaR7lmJ9H2XvfDsTkyqWQfdiSZvw55lowwWpAeLrbs
 +kp28pwlChmLR2ZWTkaMfdjyZIQAiAmeqnf4UyavLCbd36VgKlYKjAGRm0a92HSO8XdO
 lgPWfunKOH//s2HZIsazl+Ip/yQGIQXH0s1+AX2A9GslRUj7iPntEY+/i/MAFVPiRkuu
 DtYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783965307; x=1784570107;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z5F6qhZy26LrnEk8MegQW5F/7zIuhTT+D8ungh1IuV4=;
 b=sWBuV3sbWFjHD8K9/HrtqosnYYHUwwpuFXP7TIDfh3/pqtcDg82pDYre73U3aMZT97
 vQ7FQL58NUPDmfvYs8K8XHbfhPh92lUfZtX0h11HJyY0zUPSCdxS8aJwqOTB6573B6Gg
 VT4IJgr5XReu7OojSv4fqIZBdWYMBsT08QKqphapf9s6xjU+Mm7aQlrK7rrPUjlKa8GT
 l80qmH9A61j0aVxOCD37+HWMKcn49hyxwzJJ5pH1Badunb3yq/jc7cjjFM6fv8zX7cS+
 271pdM/MkST3AC0Rpsuzp4fUIwnCO22uGVEt0JnUUIi5/dEj8byjAyIMRwUCrg/jTuyk
 H4xw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrIdQAdUDStlT2pz/1Rbf1aQhgbrCwkqP3CDfYoAQ5QicIQ2F3y3aywhfHxgioFTf3rI/ZoKWCkpduY@nongnu.org
X-Gm-Message-State: AOJu0Yxo4tBSUKUL2EJ8K+WjcWRIR+UCqvEhI5/64gCpCLn/XSiWWx8/
 vuI0KugHiN1Tc9wS0Dcd/aa02Wkj2GFk9jfTv4pDRzmJMqTBREzSa/Uh8y1olzHYEuRshwyL1TU
 43BLoe2NYXpJLngigmaLuryv9DhcPm3xeHOtSPqc3u8NTQw7YJqeCn0xvAg==
X-Gm-Gg: AfdE7ck96vWlfkaeJovWhFBFK3ZKXF0ImVF37Lc/RKuDRPhrA0vAeK7c6G/VSZo5vmq
 9h56TD5W7EdUaYeXlNHzRl0qpZ1bcs7RtncjHbi4aNDzzTPy04U8QFJyFPaLInRc2uKsRZovE8+
 Cj9WEfzWdtGLkY7o8DL0lHtc492wgUFTNu2Qz5YIDmh2qnNWWNLjyAFZiFfq6wcOCuyl07mnOXq
 BJ2M4AjqmeBJknIHvGPwLrdfZtgwMAoqWmGZrF+0H2v11gTsIJWtXWFzs7hFilId1ogF/rugniD
 BiRDuKuLRJYSpKANJ9DSrzPUDdGhDw0sML2iDSlJf8qlOPM5CP2OYS8ZpATj3RjtbbzKMFmjGrJ
 QprH2praJ23rKlBSosJzLofIekmFC+NmR2Uu+AhPymwTm9I12QkgO8YuUDDGpOIkHiubFi7Bxhx
 eV0Q0=
X-Received: by 2002:a05:6a21:1f87:b0:3bf:6c07:b2f7 with SMTP id
 adf61e73a8af0-3c110adf5a9mr10678119637.58.1783965306809; 
 Mon, 13 Jul 2026 10:55:06 -0700 (PDT)
X-Received: by 2002:a05:6a21:1f87:b0:3bf:6c07:b2f7 with SMTP id
 adf61e73a8af0-3c110adf5a9mr10678095637.58.1783965306381; 
 Mon, 13 Jul 2026 10:55:06 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b987fc629sm26508341c88.0.2026.07.13.10.55.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 10:55:05 -0700 (PDT)
Message-ID: <2bd62d89-bc53-477b-8c5e-5eec69b344f8@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 10:55:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 2/2] docs/about/emulation: document the dlcall plugin
To: Ziyang Zhang <functioner@sjtu.edu.cn>, qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>
References: <20260711094523.622997-1-functioner@sjtu.edu.cn>
 <20260711094523.622997-3-functioner@sjtu.edu.cn>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260711094523.622997-3-functioner@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE4NiBTYWx0ZWRfX9GjjVC5re/iH
 BpvSudbnaiP6ns4+DBPp3qbTejSQME3cIoARU2Sa2JvftNLMftvH/1DXys9cFHGeGhVLJUstC0m
 2JpMcMXhQbHFookClIjC7caVhc/IMLozeXyV87DpgeKIuOEtVtWAd6kzQFAmVbHOAxLtG3dmLdD
 j/PscE5MkW2zmK30pO9wxUxuRTY4LHF4L5+Z00+Pc5Wg15WKfXr7LkaTd2nfFfEC3ZZTSDMvpKW
 2WLk44bD8Ew+w+Qu/sXyET1h1K8a9MOGkKXWHCE1i4POLKstdjFk3eDUoVyiq0RgGuaTF2AzRlJ
 rRxbzwCpkMsNn5soQbZN+KS/nVgJhmjMwcxsDZaswj1XLUr256qKkmKQFsx+gVSsnThvIi8pslE
 Vcv2AV+TpbhuFNAoM4IqXBrhkRc+zDr2Zu/HMnvbTCOA5iSNFRqrLEfj/A7DwE/j8EAmYOlHV13
 pPVh6+FOj49yg5LG4kA==
X-Proofpoint-ORIG-GUID: yAwq2gquvvmIXRaBHKDa5oTAt_qAIkHE
X-Authority-Analysis: v=2.4 cv=UMHt2ify c=1 sm=1 tr=0 ts=6a55267b cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=Lx1EvxgrAAAA:8 a=EUspDBNiAAAA:8 a=AvOVg3gbflhwftz5DpwA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=ZFi1QaP_tuf8dODdgmj-:22
X-Proofpoint-GUID: yAwq2gquvvmIXRaBHKDa5oTAt_qAIkHE
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE4NiBTYWx0ZWRfX8TY1F7q+zhK0
 yGXkjZpdEYnRe9I9MivayPnZwbOgh7K17aD4Ra/PmrWiDAkVfrYkiqMITJtss7b4zgoiFYlkYRG
 AVLBTJqgoadnUP8iCbLRSQjVRs1ga9c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 clxscore=1015 adultscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130186
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

On 7/11/2026 2:45 AM, Ziyang Zhang wrote:
> Document the dlcall plugin under Example Plugins: what it does, the trusted-
> guests and guest_base == 0 constraints, how to load it, and a pointer to
> Lorelei, one end-to-end userspace implementation, for the toolchain and a
> runnable example.
> 
> Co-authored-by: Kailiang Xu <xukl2019@sjtu.edu.cn>
> Co-authored-by: Mingyuan Xia <xiamy@ultrarisc.com>
> Signed-off-by: Ziyang Zhang <functioner@sjtu.edu.cn>
> ---
>  docs/about/emulation.rst | 158 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 158 insertions(+)
> 

Thanks for your updates, this is now ready to go.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

