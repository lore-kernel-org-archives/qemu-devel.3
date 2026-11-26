Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FCE606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 23:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YnXgznTe;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RmwjMPth
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWiiB-0008LG-0l; Thu, 26 Nov 2026 18:17:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xWii7-0008KD-UQ
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 18:17:04 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xWii6-00065K-A2
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 18:17:03 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQJwDtT3864425
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 23:17:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 L1LjU6FF/9Iv9oyNsWVE5JJvPuHrZRjylBsFjPVTWNc=; b=YnXgznTeE2MDtGiz
 LkRKJ850XUf7tYiIiQjBA36xXM6wI0dtAaERzQrdAzSTxrK8vyFRIBkXOiFM3fV6
 kai9ylEYxkpMa7VrfYlQpA7YL5c6F9a/U68d6OR33Ys1NFSMQWRgS7Aj3RimWIOy
 62eApIzWBHG/uWYrtqReeUhsB0anoOQeeRB0PyF/NYnI4niPAAG8npmiqQFV2X/h
 U6/rxrKHVyZmuHDATJD+lK6M6tZXKSayQ9ro0taCtV5N9k3J05BApZt/0dQ5NNpA
 KuR9Z7830oTV6fiehq143ZvlinYFpRcik8CMbzXnXbm5qQbzd75/ly8mxgP42Prp
 X+8ZVQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6u55rep4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 23:17:00 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-14373747468so7144037c88.1
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 15:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795735020; x=1796339820; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=L1LjU6FF/9Iv9oyNsWVE5JJvPuHrZRjylBsFjPVTWNc=;
 b=RmwjMPth4P09YqWuD2JJiUwfkz0gGnq2xEEszKIq1QHmLWY69D9Gz1NncygdBOjXk3
 zZU6nDAdRwNDG08MJNp0+P8FRuae/Xzq26jrMaUkxHZ3FGNPNSPstOvY7VFQC7+43tgI
 5T9vMWFBMkYYf8YjjLmY4T9KqTJw7+15ClHtSGDfGmSYuy/brkylJq6ujcgPclLVwau/
 XcqcNrTj3r4kMjoxr2sLQ6gOFZ7A2ECRcVOYArQICUITqt2flXANgtwAiEIva8kW2KT8
 tijzIHPl8HcLg6+Qs3lhbn+FQ6NhD/K8t/tyRDoAWGEg2t+dHsRJyEjAcbFuGW8cA3jP
 ARXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795735020; x=1796339820;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L1LjU6FF/9Iv9oyNsWVE5JJvPuHrZRjylBsFjPVTWNc=;
 b=ALXKFoTgLi+tmfdrvh5WjeCEUvqg7BHjRBHz8C/WB5TmQGo9/1cvZpzLN3WHVEB1sQ
 ZAr1SK/VcbrzeVJYk0h+0/o0NdD5olJnflAQ2RmWDT4zLccR+S52VOMrtqA6N4vnBOUE
 kD0UL9uK31PsLInrZVqAgi93R6g3fBVwRRK95jjUFCF90j8qZU/jfORfH3e+NTSa0gA7
 t3/vDfVIhnjvPNTUw7MTV/qHJY4RFOT7rGLtx4yjE/QiyAYfoV0BQhE0Uxf6zSQvh3z4
 S+KQX/IYvpWf/mGEjcJn5Tdt2z7m/pYWDhY6Grn37wobxkMzmE/n8fxkju//T9qwO0SG
 3JTw==
X-Forwarded-Encrypted: i=1;
 AL+hErG/hjqT35cLCev+Lc3SUEL6vMTRrQS48KCnSVcr18mOWK6/dZqk+QZt9TdhdgJCphN2Opn73+OBLAJ6@nongnu.org
X-Gm-Message-State: APuU4Z+Hyhxaegh8IARg4V31nOfEFkvEfSWVxr37U9Ta/zoxtS+oU8Mi
 3YQBz5PH/SCXPJJW9CYHJ8IlWHaKTQP5xpQYPVfnztdgZPha/6M2Htx7abdbTGtqyIvnQDEoF7/
 jxi4crRtsyeVwbNekUab2Wq2NeSPrImFMb7bvWnsYO6QNTsNRki3DrCQpkg==
X-Gm-Gg: AZFdTZfUg31levyzeE6YvHJnATg6ItsU1Am9sqbKWshoCHbrlZzAm+mVVGpgIe9jM2r
 mN3wjhLcYCKA9OgYNR40qsY3vsQF+DQ7m9XBy1eAY8AS1cy7o0siVG4070MxBMcMCXh38+z/D+H
 FXctnibGl0T1jq7rM11gXPYs1I5P+2TLWRnzEYd6qB9xkixuG1hJu2bVF2LvYEcnACrO7W+yq7J
 +MYgq3q9OtRRKo0muLVw1Ak0nN7wb368josv4cy1eXkZ90T66vBNBvTvkI1GQCWsdDITPcPh4W1
 4lFszKLo2cQQYx1rU6pTTsZuUBGiXF3Nm5REWtj58ZXwJVCBpfivh64AjR3gm/w1TFO8BLasS0U
 CV+Wstm3tV8UHxm1QfC8yweCl0RX8uXsdZ/psu9MczedQ7v4Vp2s+qxVJ+3XWHjxBhh9UuUvOK4
 P4ZUfHFvF+IBCBpV1uTQL+3iTUmPwm6LD+N2TE2LYkKE4=
X-Received: by 2002:a05:701b:260e:b0:1a7:e1c6:6f33 with SMTP id
 a92af1059eb24-1b5568d3ca9mr22489502c88.30.1795735019926; 
 Thu, 26 Nov 2026 15:16:59 -0800 (PST)
X-Received: by 2002:a05:701b:260e:b0:1a7:e1c6:6f33 with SMTP id
 a92af1059eb24-1b5568d3ca9mr22489483c88.30.1795735019427; 
 Thu, 26 Nov 2026 15:16:59 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5569bffd2sm48774742c88.0.2026.11.26.15.16.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Nov 2026 15:16:59 -0800 (PST)
Message-ID: <f017c36c-07cc-4a2e-825b-74bd5b4a8617@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 15:16:58 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] util/oslib-posix: Have qemu_get_thread_id return the
 thread id on macOS
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
References: <20261126220001.58932-1-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261126220001.58932-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA5MSBTYWx0ZWRfX1Go11HKKBZAd
 owkIqxjEn4mJR8T8ssMaCkH0fWnHx2ohvA3cSsgmXZguXlkpPD3bn1YAzFmLW2FVF5KT9XoUNcI
 R0AATedtsBoigBztiuHmCCTGn5WQNL8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA5MSBTYWx0ZWRfXwdr475cEE0Gx
 trWdxbPTi3K1l67CREn2W5m5DqmBslL43Fgl1+WN6XtpwVpgKPjRYf1S7FG8ViPwI+gQP8LDZPe
 zRuJNZFtp3SgEhqtfyrD+QncPUOiP0ZTE5WVtavksjtlTfS8g7MCmpPv5Z+4Gt88XEnHWPiV+aE
 iQd8lJ5tbSm4jxJRmseZ56zxovsUNnM0eTrKI/iHpqFSClqQCojyUP4hrSD11EfQtO0YS7jAykK
 l6Qpuq2rvT9IPqvHGZX/t4Ix3TNX91xWEqu+pYIMxP6Q9JKv68u4XfkWPwfK9ggCDHxHVujwHe8
 wx/ByTinDcXcaT0HH8GavYT7gwkhReuiIgovzMJFqKPkmnsJiBibkWFX5Uxyyh1Z4NgGH6hnjnX
 /W4rZFc0YpTYQKLoGJI732B88Uyx47B+V0ss0OKNmsXi/A7AFpsatAKrfpMbxv04MY+QITtbkyx
 +RAqdc/P+OakSRVQbVQ==
X-Proofpoint-ORIG-GUID: WLtgJje_DkOf2ZpC5fkpJ6mpJp19-r2w
X-Authority-Analysis: v=2.4 cv=Z795j3RA c=1 sm=1 tr=0 ts=6b08bdec cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=G-MrypgnJMV-7v8kBfIA:9 a=7uyHR4xMBefppD79:21
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-GUID: WLtgJje_DkOf2ZpC5fkpJ6mpJp19-r2w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_05,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 adultscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260091
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/26/2026 2:00 PM, Philippe Mathieu-Daudé wrote:
> qemu_get_thread_id() fell back to getpid() on macOS, so
> every thread, including each vCPU reported by query-cpus-fast,
> shared the process id. Use pthread_threadid_np(), keeping the
> value positive.
> 
> For example running '-M virt -smp 2 -accel tcg,thread=multi',
> QMP 'query-cpus-fast' returned before:
> 
>   {"return": [{"thread-id": 58412, "cpu-index": 0, ...},
>               {"thread-id": 58412, "cpu-index": 1, ...}]}
> 
> and now:
> 
>   {"return": [{"thread-id": 75188616, "cpu-index": 0, ...},
>               {"thread-id": 75188617, "cpu-index": 1, ...}]}
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  util/oslib-posix.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

