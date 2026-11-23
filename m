Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC330606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 17:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gNIO5tHY;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UbDH6RlP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVXuZ-0005ig-BB; Mon, 23 Nov 2026 12:33:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVXuQ-0005i6-O4
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 12:32:54 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVXuP-0005gu-3w
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 12:32:54 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANGGsTN2486542
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 17:32:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ooIVSSX7QvGnAofs9Ct/gfPKL1SgyQKtI2Tp3CdEhBU=; b=gNIO5tHYAYIzrHHH
 OYcGX1YsAJk4NkB1OvdK8PZZ4WFlXBRgYAAolXKf3cH69uP6kOEh0jBPGhGhnBqY
 C4KjMeoLk+AZRpVODsc+yd4M4zGcziOPqCEO0ajppNP6ZzZZoUF+5cKOf6+wEySF
 VFZQIDkHGyQt4kE6pRWw5+vds4F3cu1whKSg6LSEdsFi4vskDse4nxdBn7XeBjg7
 DQbFVSx9Kw03PyxDBgIUVch4DMTd4sGAgqBKjr2MXx4oa0u2UH1LgbKxYI64rn6q
 SgeEgyv8xxC6q5buaac/eWZkttbL1iEd6bcX7/jPtBI2v5NhvfSwnrRSMk7V8ndK
 BXZBKQ==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4fy02mbq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 17:32:51 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-5ecd4f564d3so1089786e0c.0
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 09:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795455171; x=1796059971; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ooIVSSX7QvGnAofs9Ct/gfPKL1SgyQKtI2Tp3CdEhBU=;
 b=UbDH6RlPL+NFVWZPLyClajDxUd8Lg/iz29qp4Nnb2SigluIpuc6dV2Ul4tpumjn0ev
 ua4B3ikvlQPsfOODuQZ5h/9O5FECE3iUtIVEBnVPBAXYjYDED0R0AIum12B2q+oKFsxj
 TIjS6bzNldb0JdWd1CN/i2xrPIFtjB5sk6Dhca9KBzdCL4xOV19Wqs8RWE+4UKlAConf
 7PPXDzu6gLuu/eE0uO45GnDKU1IKv/o03WGrXndHpDz0k8dz2pSN30mgXRSnQ9M8PqLs
 Rzj0Z/25xKehR7q8RUvaq1s+fvAY/eVJCQM0Z9wtPXUvR73Vm7+JJajoMr4QIjJkkr9w
 8oaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795455171; x=1796059971;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ooIVSSX7QvGnAofs9Ct/gfPKL1SgyQKtI2Tp3CdEhBU=;
 b=JHtpZsP1wwleBvTRQAKb8u0YplVc7d40pLjBbpGAlXBW+VmuG29kw4kVlk67QKJpyu
 jOEk9C+FtcEgOMVXOzwN7EiwcYiSb1PVO6n3Zjpcb+1PwjaLVCLdSfabvjP8nYrJ+K4Q
 Tci8mCSlizbysImrkBow6bSJCqEFiCjbvFtfTSb5hPYTwDJmjl/8I12I61pcr19kiqU9
 SrBf/MI15S3wAWWTTXsYCRhaELnR3HXUDCx5X5Hxdi/yW/kn5UVkaw+iLwRCNUnGj+sU
 X+OfXjCrqFuxhpsOijYADa2v6iTDzNMXWTR+oaLhOyROabq1ZUau6g0hwFmI15XEdMhO
 vBRg==
X-Forwarded-Encrypted: i=1;
 AL+hErGKUr5KPRYrBwIGdxFP03ZbWg46oNbJ1n4+V/xWGNAsS9JKIzAJQzu+jl9WvNxYgEgtRShSNYJJqH5c@nongnu.org
X-Gm-Message-State: APuU4Z+RrDcluvKoNeiqm7Rt50uVqOx0ULflU6WF3y35ZJkvhvzEJC/8
 8FljwgcvG7u/VM0FJuf6U+1DJVNX9SMx3Yub1U1a+6UhGzQEuveFgThjVBBZ+DMJVdDVFJf+IKE
 r/8E3qq1YwrestHO1ROHz0Cne5ammodxGY7ZcHxXhqcooavHA2vNpsoHdug==
X-Gm-Gg: AZFdTZdljmL7pgcrhS5C/wxiPOpznJFrf4kE5HvPLtbhkeeb8NXVtqrfbu+fI1Qj9tV
 HTotg7v4W7a9ZwnMBmyUIaCJtAthd8kIja+8Q+RZc+oqdrZIRSHHFnD8CgDKFOq7OYycQeJjXXw
 SBFQ6yB0UDTC203g2R7RPMacPllg37CQ6cq/JdAwoCoXjVg0IMpEToF1d/mMHwxUSM6y+qCIcQ8
 pRpVeNF10G8jq+s8n9tsn5PcGWmZy7iE+nX5lpIit5nVYCk5xntxszDIj9Yve2dXPdHErNFILCC
 ZAbt0s6eUEqi9VKIBYIhY5DWD7B+MCWtGDV+mVE2+WxPJxalEtTYdUaiNlqhJi/NhIvWZ+Ho7qZ
 d9YkktyxNt521aMx+9GvZBtNAhu4IgQhVizIE3xJ6JAJcRHsp5ebHN37h5PjkX5Bh2uE4Tkob83
 2x+/Ir0s4=
X-Received: by 2002:a05:6122:e44b:b0:5ea:e324:7c19 with SMTP id
 71dfb90a1353d-5ee8adf4d71mr5614089e0c.3.1795455171199; 
 Mon, 23 Nov 2026 09:32:51 -0800 (PST)
X-Received: by 2002:a05:6122:e44b:b0:5ea:e324:7c19 with SMTP id
 71dfb90a1353d-5ee8adf4d71mr5614021e0c.3.1795455170613; 
 Mon, 23 Nov 2026 09:32:50 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884a15absm326596835e9.9.2026.11.23.09.32.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 09:32:49 -0800 (PST)
Message-ID: <e29c8bc1-0a25-4dfc-b429-6805c373b5cd@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 18:32:48 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PReP] Maintainer status check for PReP machine
Content-Language: en-US
To: Utkarsh Verma <uverma@linux.ibm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Thomas Huth
 <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>,
 Aurelien Jarno <aurelien@aurel32.net>, Helge Deller <deller@gmx.de>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <250f899a-51c0-4007-99dc-54bd336f0693@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <250f899a-51c0-4007-99dc-54bd336f0693@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA2OSBTYWx0ZWRfX3dEyLVznCc42
 wopiDRdz/o4r9v2rZH+euFVWoEEbMuXwWaraD534gU66+HZeDirQ4ncrlfw/OE7U6giiQBo3c4u
 pgI4dNsjz8pWb5xogF27hEKjZs25n9r5a4ajFWXsP7gPzzZLeGbfleSlq/8A2U06PjrImdQjWZH
 WEKpDgUUWzFR3I5qtCpommicvVB3IZMjs+BZFSs4Zk8mFYUQ1MK6lcsFUSxvBscQMGtobbRgk6K
 ON07i0hdbqGM4+eSZzNglF3diF7c2brQ26BLD+caFZzuPp2e4IUeiPbxQksolbsdmGbksT1RenG
 Z/eHSBwKqhgGlB2fpFS5V50CTXXShVuw3YAq8cB6U/ejHQyDPAR2k4kI9VQAAJR3xQ6rw7k5ZPi
 iJ9wzySIn/QDOrR0k1QcN6D9kZ4aUVBij5wY1JAZblIYOv1PKEwjWxcOMboe+I0gj2fWMuX1WqH
 ImXqF5fmJNVlMWu9G8g==
X-Proofpoint-ORIG-GUID: pOrpYAEiAwjQc8K0vu6mwenwUCjM1g8o
X-Authority-Analysis: v=2.4 cv=QrXLTlyd c=1 sm=1 tr=0 ts=6b0478c3 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KhhB7a0FOBBhs0TNKIoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-GUID: pOrpYAEiAwjQc8K0vu6mwenwUCjM1g8o
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA2OSBTYWx0ZWRfX+uAflekFNU2F
 8qhQesaEaqnq0F/YE/PDVbRQcbf7MUFe0axMD/f1JKx+/XKO2oSEJaLWG5c+NQ31NCtkVK/HCpr
 XWkjWhnYpzpF6txmH03H9nFwCxiapLM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230069
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Utkarsh,

On 23/11/26 18:14, Utkarsh Verma wrote:
> Hi Hervé,
> 
> I wanted to check whether you are still interested in maintaining the 
> PReP machine in QEMU.
> 
> Your name is currently listed as the maintainer for PReP in the 
> MAINTAINERS file. However, we haven't seen much recent maintenance 
> activity for this subsystem, and I wanted to check whether you would 
> like to continue in this role.
> 
> If you are still interested, it would be great to have you continue as 
> the maintainer. Alternatively, if you are no longer actively involved or 
> would prefer to step down, please let us know.
> 
> In the absence of a response, we are considering sending a small 
> MAINTAINERS cleanup patch to remove your name from the entry and mark 
> PReP as Orphan, so that the file accurately reflects its current 
> maintenance status. This would not affect the PReP implementation or its 
> functionality.
> 
> Please let us know your preference.

Are there any PReP patches pending review / left unattended?

This machine works well enough, is tested; what is your issue with it?

Regards,

Phil.

