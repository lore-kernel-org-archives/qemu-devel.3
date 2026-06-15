Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D00FCD98DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 10:38:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ4hh-0007Bn-TG; Mon, 15 Jun 2026 06:38:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZ4hg-0007Bb-D5
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 06:38:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZ4he-0007cc-Tx
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 06:38:04 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FAL111200102
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 10:38:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1RlC8b2PiE2Q4PrH+iaOR8uMQQulumKnKf2MdgMxcrI=; b=gh8SMRbMjhepD7Go
 kvLb9NC16jd9TPLWtEAIShsZx51Jcri7aZpLYGdZDaD1nYb88kEMY5AhJd9oTT+2
 4OGx4Dmh+HXfsLlBOBZ5CZrp7sqg+6xskwkWcEmGVLfyYwBeNg1c3rWSzFziC8q4
 ngAPzAMR0Jp52gz+M+a/z+UuwBajort0cQw0tLbbdjbgMX9IQdXCT/R7wac97A/L
 XxxarTVeTLJisw9ev/H31K2UcH/dGH1ihE2mwOt+UpZOBVz6Yh7PICwnxW+MqsjE
 o3frmRSjD742CG9vAN5kqyBmBKIGc25aIJOBCChddnY7FUFW8SlFug32B/BkNn3N
 O/DQuA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etegurbh4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 10:38:01 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-915f6ff639aso939708285a.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 03:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781519881; x=1782124681; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1RlC8b2PiE2Q4PrH+iaOR8uMQQulumKnKf2MdgMxcrI=;
 b=kh2cl/J3Fssw/jVWQrlVMof+Znzq0UBxhvcRO+jTv+DWarlXxVPgxW0YqDINSXD1/G
 4ohjrL643dx0GqTAiYHkjKCA05zRWCJnfK2qMi/i/B/56MFtFJF0lbJlfhGkwRGTHWpa
 JAh3pAkwGYalytvTN02+I/V+FmWrEPBxQl5C4JXtwgjtso0VYvj+se7bMlPSXeGYf6kr
 sPbF/4SxZOV5piV8U/Sz0UXh+/6crmLVAZ096/Th1uaoUNMVCL3Si5/8fehHFfGtuSJD
 hlf+dbASTiXQzWX5bRWW+bOycbu05j7O3ggWLdFeizWIxnIAifjlMbDVivGQgwnXdBUh
 ePVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781519881; x=1782124681;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1RlC8b2PiE2Q4PrH+iaOR8uMQQulumKnKf2MdgMxcrI=;
 b=gPtaa2NciZjy7XFkvTnADuqWBAxVHKKp6E+rNYN8YqVRdu2ASbsLo7C/vAwuWIZUJN
 i22GlvnWhrADWv8MN/Ue7D1wwAZ9sFFHh/SL6jGpd+r6f5Su6pJyrBS65dLbCFPviymP
 I7yujhwpFXQJBdI6TSSHCCmeoC33bYM4VoZ2JAniOQr1SvypUVwboYHJlXLPVCd4o7WP
 tkB/rZJSiW7N6t1F7Hvp2gepM5QnoicORncl7CVzTBZFUyfBCEq1JHFwMgiHk6PFXqV4
 uufYaFYbDTg0zIly7zr9okAnyCKEzyWu0om55YM6r+ZDkyNttbOTvz5Emibgnw+ZGmrf
 XVsQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8/AaKVVuAznLiRrie1Fr91YcssFUhe4fieVsgy4wRgKU830aV1INkzKsIn64aGaaDzl9E5tIICLoZi@nongnu.org
X-Gm-Message-State: AOJu0Yz9UBdE6Hgkpep4zo6qI4tqt2czOXjjBCz2YZ1wgi06jkDHOaZr
 wurSBsvR/9HPiM8sDsbCCjJJUu4HA8NH+0UR0czbovJImAyS1BKM7tzjd/Ce6y9tgug83X1abve
 MEZcti684j4LabUouNfAp0R31utYq+wAqS4mtxrtYu/3jTV+iD3TwVUFDcgxP9Xsddw==
X-Gm-Gg: Acq92OFc4/vRf2WbmRkH2qKPCN0ePzDN4GVi1BMrbU4NBpVXThWAMqY+5gRbtu9H21S
 AVETbz1QSdibAnssojFRwJXyfWi1al2hLUrVFSnRzB+VTQ6DP1bNAQyyH2yUpj9OU+UHuM9D/Uj
 U3z7R5ofLJlXipRZlBQLdrSQQKCd1ol8V/gnxOkPuP4JoQrHh2bG4r5tLGuXbhBDOhqLTaIqCva
 zuQ3fMn2NM3FMxPay+/S6JaxDuPExr21RYg2rdwsWhwDVLcpkbyGCUb0PEBfZvs+gUsKlL7LNgP
 njrl1LR1jNhbY01VSvMO95cQpQ0Kt1/e/E9Ig4C19CnoKnkXVejeTnCmDEh/4thQlaOIXyV7x75
 obdQqfZbDimfcsZXiWrZeZZfBGK9l+BsiS69riLi9g6MHqgdps3qVDiXV8xxmZ1wJ+9M6NhE8
X-Received: by 2002:a05:620a:410b:b0:916:1767:592e with SMTP id
 af79cd13be357-917efcb330fmr1598638585a.24.1781519880978; 
 Mon, 15 Jun 2026 03:38:00 -0700 (PDT)
X-Received: by 2002:a05:620a:410b:b0:916:1767:592e with SMTP id
 af79cd13be357-917efcb330fmr1598635585a.24.1781519880488; 
 Mon, 15 Jun 2026 03:38:00 -0700 (PDT)
Received: from [192.168.69.214] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bfdb51007a9sm435721566b.21.2026.06.15.03.37.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 03:37:59 -0700 (PDT)
Message-ID: <61b63a41-ab27-4366-a565-24f912caccc5@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 12:37:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] python/qemu: dump a developer friendly version of
 cmdline to logs
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>
References: <20260614100902.885698-1-alex.bennee@linaro.org>
 <20260614100902.885698-4-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260614100902.885698-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDExMSBTYWx0ZWRfX5jMYavP2+EBD
 pZJW7p1n8wR9imR/zfNi9UjVX/oUgZ8+A/XGS/HqjSARft/O49oL2n84zRKztJv/1MW2Q0Ix0P4
 MdSStlLzub4F4GLug3tv6MMTSbTq96Cv1qGQ7maeMXeyKRNijyGI+eGpAwUOK8GYLkh4a65pyCG
 X09V97koeacxx0BE2yoJGJhsRD+oYjOXfDzMok41ml2uvzhEayXj+v8YKbB6GUhbDmhaMg34vAA
 XMB3M4zLmnc7PyifDS6t2/ylqWjYpTOu2L76enS51gaHANXsabMl6q6udQvxd/8HqYV8BUZ3c9a
 /XuR1P1EEqTtrf2nlR+3/lLKrlMr4JBG1/sCoRKVJ0GKrhN9isgEvLLs2mpUTV1Cj5359g06sdL
 bwSxedY33ejtP2anipc+ThewqEZHR+b3YepuhUFak9F4wxUOrcXWpOm4XhqQUfSSBHZK0ENIH3M
 cBvilVI8M9/LLSePI9g==
X-Proofpoint-ORIG-GUID: dI1of78r5N9IZHz-Zw7VC5yFQrnXU1UA
X-Authority-Analysis: v=2.4 cv=HMvz0Itv c=1 sm=1 tr=0 ts=6a2fd609 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDExMSBTYWx0ZWRfX1XWtte4SWTZX
 7PEmnMor1hOtlbx3urOMtKcf/VnUZxGFbbUPZWFug6ucjqNeXrHvTkrg7j5LHAhqyHQh+rGQZCI
 IERDVRZ0sZN8IYy/OH0jYddIEz2L4Qc=
X-Proofpoint-GUID: dI1of78r5N9IZHz-Zw7VC5yFQrnXU1UA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150111
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 14/6/26 12:09, Alex BennÃ©e wrote:
> Now we have the arguments nicely split up we can make _console_args a
> function call and present a slightly different version to the logs to
> save developers manually hacking the command line up.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   python/qemu/machine/machine.py | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

