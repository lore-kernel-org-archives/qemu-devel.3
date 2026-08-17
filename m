Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D33C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 06:51:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvrB2-0000Ud-JK; Mon, 17 Aug 2026 02:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvrB0-0000Sm-Vs
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 02:50:31 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvrAz-00086e-40
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 02:50:30 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67H5oB9s1328040
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 06:50:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ASTioCbP8egLitGWVsn4zjG4PcJjei1CLLGqXhezzDk=; b=OSoAKnbIVOKjlqs+
 d6c+93bAOBOSP8FzKriqk4vU/CzSSVmx05Fhj9HtZ8eF8wvEC+WUTG+YwHSWAJg3
 m4USsqmReT7I943j3A2LRwJBRw6JIMrhIdshwt7UhH+VUL+1M34YqZfGnrjQQXnH
 HKQcw9wrBlgnKQmnkQssooujEtW2ES8fWxb2qIZ7jB/RGaWRBXAZhUx96HOkRNZL
 nHx6BeFexUtOZ0tbZUnfxq92gA93UDfk9gXdp3WZBL237O/pzlji9GVdFg/Z8EmG
 T7yHrjr/bg1N6BpWc/RlP3tUdSBy0yfTD8jocbsErHYCcgCwINpxB+lwZhiLM1Yr
 wbockA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3vghr7p0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 06:50:26 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-930b6bdcb4fso452677185a.2
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 23:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786949426; x=1787554226; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ASTioCbP8egLitGWVsn4zjG4PcJjei1CLLGqXhezzDk=;
 b=PGtaI/JaLjD1wApZ3wteh1eEwChESmF/qzeRHKOfwqpH7TziUqtmftEs5tV+16mFEV
 iGmQtrrBnr772ObhyhdHn/NJv04oW7kUWTSBtrL8eEDjaHuEbAOM5rmJ9rqkSJa67n7w
 qJSlRIuIPWZmAjo+bxnZb76KDru9LpaT0EftbilA+fKqMjKdqHB2uuiXID2Bqz4SmBJg
 mcBuco5qSo62YDsca13bCxhbhvDrm4v9x3JSrx5/ql8wuiAZCvH9oAYJj7bz4EQPY+p3
 C57+OROi6Gmdlrz/e6jAEQpsoeRJBlqbRY/1L13hbTOlOwpSqGIfMkz14SqXpMWhy9ST
 9vBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786949426; x=1787554226;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ASTioCbP8egLitGWVsn4zjG4PcJjei1CLLGqXhezzDk=;
 b=Gz6ZccpiPU0q0G7LDZTkw7l0sbG9r2Tga68q+6kgntoheimaLQqHhOXrgSuoKbN3J/
 cbpDMHzK4okXIETGeO54nf7fyVVPRgCGkR43dhK51cCad6KqZkQ1AMZwgiIGOrsC4oCW
 jH18SBXrqXYe0YZ7BhUW2PeVAxcfS5SynMHagKeF+6NK4LroASoq9/XJnJokUJrrcTL6
 xTKGv3nG5jdFwz2usP0svagY7Nfr3vyqDXAi8hLF3z3RdzGx63JX//zzL/hAsmX+im1l
 1tINCE+alNv1ULEbcMrhQOZuvPy7IFvDvLK4Gbx8kktzrWxzESCLjT47022umvpPIJow
 wrSw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrIf0XMB9ci/nQ3C0fIMqRIdSgE4PdRlap3khAVwQqJwQOZ9f+YHlBYrfLZDoRSa1nPrj6XnrF8Q3rL@nongnu.org
X-Gm-Message-State: AOJu0YwvjaFx0Be9cxow1ak4KXqkHN27CoKdTnVolyqbaj4d/1khBjE3
 lhsUzsCG7p1KUkJq85ycmEGutnES8kGRhPYcfhhFfdfWa8nhamE4CFOXGgXHzWZbmRoRjTWxcc1
 YjF7ysIF0QN+CA+ksIZhp7sKGKUy/qdDiqYgyd1BpvqI3qiaHQMlkDTbwsg==
X-Gm-Gg: AR+sD13U8+ykXA3r+Wf9aRU4CJtc7wd/f4kD99v8sM21wt5PpIDy/dytvz8ikeHLtpu
 h5NBYv93XMz7+twG1nNwJWeAP0dHIh/AjygleJ2eViQEEvL3OvaQZL7WGCwuKPv9kKFQNsb+WBX
 OLOL5YoJeB8G5cIagct6WwHEOnSzOpyxJSx4zGPkkxDmMRI6tk50HxoYM6Esq1QQQSoWkzYi/Tl
 tpBwCFl5nTOqOxlfYaq+J6OtzC82/Hy/veUUfZHg8PuLzWSm14GY82PwDhU1QgMTWoJiZnu/qoj
 IA0vffzSydv0mXk8PnUhq3tvD08CUIqqwQporvunFNRm8CaajHhhPXpgc+1k0mB6PRmFtQ/sloA
 tUu8CSu7J1SzEYBbHH1tELv2q8jgWE1br/q0=
X-Received: by 2002:a05:620a:1989:b0:92e:db54:a2aa with SMTP id
 af79cd13be357-936d1fd5726mr2190933985a.3.1786949426426; 
 Sun, 16 Aug 2026 23:50:26 -0700 (PDT)
X-Received: by 2002:a05:620a:1989:b0:92e:db54:a2aa with SMTP id
 af79cd13be357-936d1fd5726mr2190932385a.3.1786949426012; 
 Sun, 16 Aug 2026 23:50:26 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999d078523sm17253055e9.6.2026.08.16.23.50.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Aug 2026 23:50:25 -0700 (PDT)
Message-ID: <876d0a88-f3d0-457b-9e1f-4ba920acd477@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 08:50:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] hw/usb/hcd-ehci: Make get_dwords() return bool
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "clg@kaod.org" <clg@kaod.org>, "clg@redhat.com" <clg@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260817055318.3826428-1-jamin_lin@aspeedtech.com>
 <20260817055318.3826428-3-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260817055318.3826428-3-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=P9gKQCAu c=1 sm=1 tr=0 ts=6a82af32 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=V2NxCb60AAAA:8 a=O9fRh1Evy045R63fx-AA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=3L6qF29SlnrayQqPM2jZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA0OSBTYWx0ZWRfXyo6kjApEu/KX
 dQNQJyp/ARgzXQZ55qQ73kJ/RsT1JZ9bCpTqmi1FqjW54w4oO9DgrJE26ABZeJwNmFIeSq61lYo
 P9IBDbbvAzfX5XmRJP63TNcPMHVbNZc=
X-Proofpoint-ORIG-GUID: cTm_iC0n0ZhO6F6vJVrWRL3Q1EhjHdJ1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA0OSBTYWx0ZWRfX2u341YNtR7WM
 /7qeXBJEY7dHxhuVwy540FqODnlGz6ocBjF6pVRM4yKYtSS+bHNJhWssiDs6DbL+GgcACWzYZAd
 wPpkWK6DsZNMBElfwuPsZI03A43ZEuI8BjYcza7qn5DOpGnWRKunA13gEBltEcwBc2NhKBpBjjM
 BWh1febXWHOHcFV+w8u+qRGvoeS9KvrAJuidbVx3vJWWNPQNTr44Kjs76vS19ieba0jmEymnIxE
 5U2Nr5QukLEhiOy2VV2O/zHis6XmV9MBig0jw7C+rpcFUYmQAbiSd2VJ/H2OBBx6Kjy8mMBI6hb
 /QLfLeFomaC3aXeajaXjs4wwsxPVVYCT/r8kMaxo1uzBNPsHm0dCp32AulPqF12QcEfDuF5x0HE
 hnCxG7ldWFNk4QEDGoNhWa6FSkrdH821ol4KXgXRJEKMzr0oDo1JndlNwuuuXG/U2ZIBv5zQb88
 CYgDhctlA6LlMifGh0A==
X-Proofpoint-GUID: cTm_iC0n0ZhO6F6vJVrWRL3Q1EhjHdJ1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170049
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

On 17/8/26 07:53, Jamin Lin wrote:
> get_dwords() returns the number of dwords it read, but every caller only
> tests it for failure and none of them uses the count. Return a plain
> bool instead, which matches how the function is actually used.
> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/usb/hcd-ehci.c | 44 ++++++++++++++++++++++----------------------
>   1 file changed, 22 insertions(+), 22 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

