Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A126D606CD48
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 16:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DLIIaC3P;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Zk/Xffd9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJZ1P-0005vg-Ag; Wed, 21 Oct 2026 12:18:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJZ1E-0005tr-0E
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 12:18:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJZ1A-0004gO-7E
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 12:18:23 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LGDcCH1655618
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 16:18:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +7P4Ra2FlG30IEFvPOMTnlF5m8H8Ybi6OBXmLG48TzM=; b=DLIIaC3P8GGB0yEg
 hyVcgvaJO/CdwA8H+88ytX8tXN0ln/0Ij8kd678L+M6ySLtY+aoLSvWdM9aP+vY3
 7UI0jeQEy/ZFDJgy42fPAAZrymZiFOe1ir0Viz0UkEw6qIaUCLM1fbMxk0JjkfKd
 4nOgblI3tQdkck3N+U0kOT1Ef7lCD/LAv1AI8nDXiBce5UcK7P4aYcFn7TIatxzT
 /dEUiDljkajqCmeK6IlilyT35ECOL5zntQGOtyIGvUKcu2JloZPr9Z2ip+7vzKdJ
 YzL+eWFyp6WJf98iQB67/qZaSj0hFbYXQOLR1Qd5Uk7ALOZz/PPNWxINXj0bI8e7
 ZA2XkA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hedajmvcr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 16:18:17 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-33713e5e6daso1463892eec.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 09:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792599496; x=1793204296; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+7P4Ra2FlG30IEFvPOMTnlF5m8H8Ybi6OBXmLG48TzM=;
 b=Zk/Xffd99Ew7UU9byT/H4cvxGJme3f/Msx5mr7wdXhdxqELPwcgm91yQvDiUHqmeP8
 wDj2aux2/uO6Nf9lqDfy8k+zoKhLg0ZpFaO5PPGpLloraI/5NG0yrpwTwvi3840KbssC
 j8dgNd08hox1FuC9Qq6O8FgYkzeLrJ9sa5jpm4bd2/2wW9Reb8lhXHMT9jcvCh+yXzyJ
 j3l7/GT74IAEoE3uQCL5yM+sdQhS0zncSzuCOzplC+iUj+nPB74J1irxQMAluvofOFz3
 Xdii7ShnkPH8A2RAvur3XJu2wWorx8EnW103X2qyruLOs7vKsz/e+8PDz/jWszIAkNFm
 saRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792599496; x=1793204296;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+7P4Ra2FlG30IEFvPOMTnlF5m8H8Ybi6OBXmLG48TzM=;
 b=w0OuzOz7xThzjtjBpBhebyhkUFL4GAzy1XubItLk/ZLhg6ZolMOxZahsXT11ca9HfY
 JnB7wQb8gxSl41s8EHfmkeZD3F+B2nLaPuBDyJzlnf5NLtMTieaikHV/Ynr2/f9fxFYz
 rAth99wFrI0S6yF3t9vEbIO0KxDf2sJlvsOW6PuczXaKJfSBxi1kymIZBxzT0ppZq+AA
 jIgYMmqLxYs8sYQerz6M4BNBaQ9iJ4lfLbJDtvlQm2+Cfc62tt956vZOlZgdW5PZpDce
 JALH2r8KoWv5vkLA6CpZCuC789+A65U+fM2QJROKF8GqTKWgF9xszc39t3avoPdQ3+tc
 Jhnw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxKs+91OT5z8r7N9EJB/Vb4i0YCooopsHnM4RLBcn774iQgIwurA437+oN1Rd33UtTbYRE89fW/Q6qt@nongnu.org
X-Gm-Message-State: AFq9FYLPWvA8//Xh2mNVLhSrFfgdKJ8cV+AlKfCAs6VtilaPuEjT3OPe
 JHlz/5pLgDLhe5r7OoFlsEMkwuJHn32TL3UHajvtYtmnSiCudd+tukTeQLaSgeWenvRczucKo9l
 J3ehO9IU/XuL8DbSwWMeRt6NtHPDetANNfVQKQS1jn5WaMBL91VIkvywrhg==
X-Gm-Gg: AYBFou00tWejDR8DUyng8KFLkgtoCQKEqG7mI+XxjWGeR4lZNQkKFqNRpd1RD+p+wkw
 mLq8RBaPqWNdHp4ohgrESniL+FJCI/9qfDkRDGZeM1QUsJ8ShFUXeUKWqmtIsXitbjXgC5fgbLt
 F3QmV7mI1noC1ZpB6qJoEB/T9a7hOAMq1M4R0psWP0mpkgcWzwRrJyN23YDP/80eJTe01u7j8pi
 GMJgTsOyY/zp6f6AekiB9TxT/Sux6NOpJvBCR+Ff2jMsZHIqS3dRG3WJhvtbq6Z8Cam8igqD72W
 FVjUqItTxrZNkze3cprzmWdCA8hVuNCRsRE5jOfE8MjLOPJU35qe9ffHPp+16rlTG4qV6DRgpmY
 UTbjdrCngquY8qsFgcMLe7ShLcmXOcGka0QKtukStBnGnSp5RX8i9wEFXa7zbkHoSemuZrw==
X-Received: by 2002:a05:701b:2608:b0:14d:5a09:5cd0 with SMTP id
 a92af1059eb24-190a7d16114mr2724013c88.42.1792599496131; 
 Wed, 21 Oct 2026 09:18:16 -0700 (PDT)
X-Received: by 2002:a05:701b:2608:b0:14d:5a09:5cd0 with SMTP id
 a92af1059eb24-190a7d16114mr2723971c88.42.1792599495418; 
 Wed, 21 Oct 2026 09:18:15 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1903ca044d4sm7598612c88.17.2026.10.21.09.18.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 09:18:13 -0700 (PDT)
Message-ID: <5e3635d5-1bd2-46b2-9f7d-78001159038c@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 09:18:12 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/33] qemu/osdep: Add ARRAY_ELEM_OR_NULL() macro
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org
References: <20261021031407.24862-1-philmd@oss.qualcomm.com>
 <20261021031407.24862-2-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261021031407.24862-2-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfXyH5wIezvdq9e
 sqTyi4LjBSKEyuFpLMedWHFdYYUMQ2AP+tJVqS7BGrFyBTXXaqL59xOfGu3gfETDOPNZsm/ZzSh
 2C5ZE6znapBv6kRKGqTqoRdKpiQrIEUaXCzlhoc5Lej6C73mcuHNEnk//ULSgRuSgdOukXjD0zf
 +N40/fGDqCl/7nKMyQD0xDL0KwmiOH+3TI7hND0ZkrdO9Alom5SfVzfJh2pV/6qmgDdXf1EUJPJ
 VnS9LgIyIoeuEQt/5U0159RLNrMnNipvLH84nlUy6eMJFxPtU9wfMRtEergwUCibPFmczwpY4QW
 DM27S+NinwhQVxqs18CyneGRCwNEUzPXeW08oAc3ByRZfIEak8JKiLL09O1kVXFfPhvPPR6N3an
 dO6oJlZEfhaBeV72D9A67TsCq215H7l/shxsY3W209xz0O5Y2BpSDlDhfQY538N7za/eR2jSJg0
 vbWQPyoHF+lRD5E0SAQ==
X-Proofpoint-GUID: iyKKXHuOAcUj5RHHrhck3XsbXX5t373Z
X-Proofpoint-ORIG-GUID: iyKKXHuOAcUj5RHHrhck3XsbXX5t373Z
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfX4SIbStvAcn0C
 AIizbCGn5h4CJEH7sTEyhZDCg+syE7gx5vQ1cUTzfaeZ+uBIwNQ4tkLDDrw2lbcaVcz7o6TouhY
 fWPHtfQVarNES2prrTEOZpj1H91XC9Q=
X-Authority-Analysis: v=2.4 cv=HrTjiETS c=1 sm=1 tr=0 ts=6ad8e5ca cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=2T9r-ujFxUm_s10wYvAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210064
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/20/2026 8:13 PM, Philippe Mathieu-Daudé wrote:
> Add a macro returning array[index] or NULL when the index is out
> of bounds, useful to convert switch statements over enums into
> static string lookup tables.
> 
> Suggested-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  include/qemu/osdep.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 1ec5b42230b..993c8ffde0c 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -533,6 +533,18 @@ void QEMU_ERROR("code path is reachable")
>                         QEMU_BUILD_BUG_ON_ZERO(!QEMU_IS_ARRAY(x)))
>  #endif
>  
> +/**
> + * ARRAY_ELEM_OR_NULL() - Return an array element, or NULL if out of bounds
> + * @array: array to index
> + * @index: index of the element to return
> + *
> + * Return @array[@index] if @index is a valid index (negative indices
> + * also yield NULL), otherwise return NULL. Useful to look up entries
> + * in enum-indexed tables without a prior bounds check.
> + */
> +#define ARRAY_ELEM_OR_NULL(array, index) \
> +    ((index) < 0 || (index) >= ARRAY_SIZE(array) ? NULL : (array)[index])
> +
>  int qemu_daemon(int nochdir, int noclose);
>  void *qemu_anon_ram_alloc(size_t size, uint64_t *align, bool shared,
>                            bool noreserve);

It assumes that array contains pointers only. If we restrict macro to
char *, with a use of _Generic, it can be enforced at compile time.
Another solution is to define a companion inline function that takes a
const char *array[] parameter, so wrong conversion are caught at compile
time also.

Just a suggestion though.
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


