Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3050F606A69C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 10:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ibluOtWS;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SYY3sJjq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVnVs-0001C6-PI; Tue, 24 Nov 2026 05:12:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVnVr-00019q-CS
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 05:12:35 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVnVp-0007sk-Lm
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 05:12:35 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AO8VJ2h016820
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 10:12:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jX8ieBn37nC3xrOHJ0mdtzKH8DAAb7phVjfszuu4AFU=; b=ibluOtWS8L6cfn8D
 IOLVZzQOysPsY8zp0EHBbnkjv0o16YEjyDjFYMKcHhSo29WvcvtheOYECD/pb78u
 NaQZ4tIKYxm/xyM1c409ZuT2YzPMJqjI1of2ov1mtt8BixyzEA4PjjQf55PHLfFA
 4KhWtLYA7EUWugIygAoKZ+Plg7UWlp2jc++IJhZaEndXraRbcd4SLB2uXdcF3CvO
 1CfUzOqaNBioJcjYqfo+0YKW/MOIXEN6RXo+Nk3vn6NGghn42ZMKu8UHovEKK0dc
 ofuA7/Ph4LCDvWJGwVbPh0gBAXQvQ8lDlZEs3p7DhRPmoZ4kMWLPpyuNMFf4FdDs
 mc1UIQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4u9nu8wt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 10:12:31 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93cb7f9bb86so852750485a.2
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 02:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795515151; x=1796119951; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jX8ieBn37nC3xrOHJ0mdtzKH8DAAb7phVjfszuu4AFU=;
 b=SYY3sJjqj8k266/TjlwoAIl/EThc0vmtS6bBVAoDT0KfuIKFU6g13aSaed/WPjG50t
 Gkxf6jesGGjMbWN8xxTMerVJY4nfbtiKz8ccHFagUUAGiBQxO997JPdLUux2Xzv78jtN
 oXNn9GWSQXoa9JUlADpQRHP0WSTNsBF2wYfIcOk+DzKTjVhIRvkkKp8Oq55wuDBTNjyp
 pIYwG/8ASmS8BaefLp8P898CUNQLqv22wWvT1qQ58xnzHHHdiKT6xcjfaZfIp7TfnuXy
 WmXb/J0j5mVHuMwDmD0rCHbHMH0mkXG2k714mkfcxaVUMuQdMJ/KFp7N2vGBJLZdj256
 JHCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795515151; x=1796119951;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jX8ieBn37nC3xrOHJ0mdtzKH8DAAb7phVjfszuu4AFU=;
 b=uupZZ/Ei7bWUQ5bJzbVpnEQwNMzyEfaZTuKph4nsOHC0+YGdJpIQafJ0klnNbtmnXg
 6ov5DPYa185+i85Z1nrhRdsaaGeS9a67xdcjiQZ7rPP7Tk1N3iYdqr7b0IWA1Vpt9fiO
 gigwdsOVtVEi1xStEHcGmYbQAcRQ6HHPXJzW+nh84lRfkZvlHBxSqccLvt1LjWvfkyBe
 wCZx1B68KFj2mLM0gAAKFw9V8Bq+ZIy3rzU80DJAioYirlOArthtGCt1sFfXs4ZpAK9Y
 QCYMwQLtw24eYEkC5REnHC2IN4GMlnnr0rptD23jEtEWmn/6HyWO/0urXvaMN43bxB1X
 UEPQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGmGOdysx9DH0DMsuDsExrpzVByUg3XN3JDC0nZrSPPYdpFQFPVPybfWNzwUK7rhiVOK3rtHHErdHu4@nongnu.org
X-Gm-Message-State: APuU4Z9KEZYzeDR4c1Cj/OV8RSAbrLDuBNmR1w7lIlgbWYVVZzWM+/ZF
 V37ZNiAjI+7DFdgCzkfqghSJYmo0qAINh7cTu55rmVaLn++EOVUUPWz2skBSdW7+bBd2L4FlERg
 6CVSQq+nx5vsf9nxRXc8L01KMXFWEbYJL37PP3RL1WnB/sBcwIo4wLftG/g==
X-Gm-Gg: AZFdTZflmoromfbzds5cWzVatxRxbYO23+ilqQ1wg5dNDnN+jqHVDM8fI5qDW0lyFwu
 PGcJYjWTOALUmfUZsEAx+5e4PKjgBE6XpmWV7osyzj6BOtVLMctCpkcHDKJ1dwq31NR/HR8iiUa
 gandgrLDx8ENqT9aYv6/GdERUmHcwxWZlw2c6jK5RmRSbIo1Lg9WZ8U70XARZ8KTJdFVzWEdeRN
 p+Oj2t/ZCWFjvYwhJdYp74GjlgAd2QNRE+NOZSkas0WBEWlkYbN/eVmVeWHxD821/M82WaH2p8l
 HlRJ7sna66W5offiIFT/Kr/Q/6vxee7CNJvWRrwgGrW177965gHtH2N9T5gPk91hY0WgarxSsf8
 s4tc2/IA7dDSlqOTj1rZEKREjZS2O8cSTTLfabGOsiRPD2QEhT2Tb8hKC2E9fWP9Y818T88y3uN
 NVhUEaOBw=
X-Received: by 2002:a05:620a:8812:b0:944:941:c060 with SMTP id
 af79cd13be357-949ba95df74mr2255650785a.15.1795515151213; 
 Tue, 24 Nov 2026 02:12:31 -0800 (PST)
X-Received: by 2002:a05:620a:8812:b0:944:941:c060 with SMTP id
 af79cd13be357-949ba95df74mr2255647085a.15.1795515150700; 
 Tue, 24 Nov 2026 02:12:30 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b2050f1sm26766039f8f.38.2026.11.24.02.12.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2026 02:12:30 -0800 (PST)
Message-ID: <82f86f82-1b48-4894-b4d3-cdb7c36f1c65@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 11:12:29 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.2 4/4] hw/display/vmware-vga: Check incoming
 migration width and height
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>
References: <20261124095719.4126146-1-peter.maydell@linaro.org>
 <20261124095719.4126146-5-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261124095719.4126146-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAzOSBTYWx0ZWRfX/6lbLHdJNmu5
 6HdmVuOepDEIAS5zBm4UtP9yHCIcaTKfpnKowVzHxt33bToy7mEmhsiDPkV1dTNhp4YRk75gXDX
 U+V2UwwmBRlFZoDld1JUEEw+2optlPN+ZUjxanRi0PCR3oS8QCusvjx7h2rwZvnkwv+ZJ9u++Lx
 aqifD8R/My+lPs/3IwCbn78xzK/TE6TEw0jxE7dh1OafgA0EF6m6jamKhjjMGSs91IpmIY6PMl9
 rRyYPF+94Bpw1pfpoHjIFspp/LL4FBPvSIh9udwZEhbc+oJ8+NmHga2NC+MNxl/5q07oBJEr2Q3
 YW4cD1fD4WE6YGG4khptjjtpfRtjRtDd7KpbySgpMmYzramhUONdbDI8e4Ad+sSbWo4nwvvyO2N
 /YJ0OYR1TewRqtu6i79pxndXJtMWaUAVxMrT4vVZm/K9g2Rbsy7Bk75vd+VqAGS6mgEP3Bxu3M7
 bYY/XWTVqThFFG0eOjw==
X-Proofpoint-GUID: HJhlZ57hjMRSLkzIlNDN_sV6yGkWj5iz
X-Authority-Analysis: v=2.4 cv=f4ndl+yM c=1 sm=1 tr=0 ts=6b05630f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=p0WdMEafAAAA:8 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=LfsA7Cq2GQzuzbZ-N0YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: HJhlZ57hjMRSLkzIlNDN_sV6yGkWj5iz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAzOSBTYWx0ZWRfXwie/WcZVxdwx
 6ZFXhNrCesGijYpMih4DMo59j8367X7FJtNrp6CVtEAQP1IIdoZ0RWGRnoCGnWs/75x8D+rhlJo
 0poXj2oSkE6vC/0EhhlpetYdrs8kzrE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240039
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
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 24/11/26 10:57, Peter Maydell wrote:
> The vmware-vga code sanitizes the screen width and height when the
> guest tries to set them.  Apply similar checks on the incoming
> migration data.  This prevents a manipulated migration stream from
> being able to cause us to create a surface that exceeds the size of
> vram.
> 
> Since we already put in a check against creating a surface that
> is too large, the checks here are for:
>   * ruling out a negative width and height
>   * catching the issue and failing migration rather than letting
>     it pass and then coping with the out-of-range values later
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3870
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Ideally I'd change new_width and new_height to uint32_t as they are
> never negative, but I'm not sure how to do that without awkward
> contortions to retain migration compatibility.
> ---
>   hw/display/vmware_vga.c | 5 +++++
>   1 file changed, 5 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

