Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB4AACC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:32:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGXvW-0003lL-Qg; Tue, 13 Oct 2026 04:32:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xGXvR-0003kn-K9
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:31:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xGXvO-0006RJ-Nn
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:31:56 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D3xVju3476315
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 08:31:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LBtQKM8KktQItBMXEniwvGSsEZXdOkpDztZMSeXvuV4=; b=TVkpliXs6WlAK0UN
 CMTxmAngmafY+ls33oCkO+RjwrdB/G7L5LNTz5SJeUv45gGNK2PDY5WV9DGEA58j
 l5evi7QKPc7TtVYVeMwSsYts8Gj35Gats4K/4j80tPiTmrF1W2YscQuo66jDUfdB
 /aa4Qgt9gXeMZyAAArrabV/58aZSpC8Uj0HU3V9aMRZd/7R3ltg9gO5MTtvJNzxC
 /EaPy4l8bMsx+7VgDzEfD4XaUT2K4UKmVB2vX+xaEeqg1lLQTmCJjOkIMymXkk5e
 wjAm6ZN50teH6q4qrPe+RYi3fZYwmc8Z+7o54pYAbFnHnNcGyeZZTQpYQiUCRo70
 sIE9DA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9d7j90wg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 08:31:52 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-934963b2bc0so533309485a.3
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791880311; x=1792485111; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LBtQKM8KktQItBMXEniwvGSsEZXdOkpDztZMSeXvuV4=;
 b=EbEOrIiw6I/NNA/+DmTnQhDHkYfFNflxiMiTMV9MMDqGN6SjSD7665RauhmCPBZysK
 P6WZOFVaHC+s//79a8lo2wUSHEfNGYM9c88sBUuQzkXt/5G5E/AMM0iqjsWzaajqGkWS
 woyhiQ+ZtEoclGzjhQWP25cBhNOSB1YL1onYLEspazhoAHNfA6JrWp37aWOmS/9j6uwX
 j88Cd8uttv/NtgZR3fYNf/0L1gFm2YSdwfd5ABwTlNzMDKqrLgHED1nlwW8xvuW5gYmt
 FABN8vPfT/b4f9YU5k+FHSdMDFTszy9z5XOKK91cKwbhs9IrovO2EGWEuTX3prmDit6V
 pB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880311; x=1792485111;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LBtQKM8KktQItBMXEniwvGSsEZXdOkpDztZMSeXvuV4=;
 b=s6RU+Xsa/rOaDPpheT3TPjMMvDvL4w4L1Dn4qEJxwgbS8OdZzO3DdKpl2PRgQN3y5q
 N2VH7aSPtSSZhSI7fDn81Si5X2ziaQIip/G+HOMN5VYpMW5glpPID6Srw6ECKNBJwjTM
 NYBB0Buq1Tlw60WUqo5Aw7LDv2DbD3HtIp1aJ4T1kR8uOYjecZcB8P1pYSCL/z9LB45l
 VNMx9LTP5mJWlgLZjVyEbmAe0+JHEWCd1R0vfyK3sWlradgrJddF0G4iOjrhTy/u2PIN
 7LNa2TbdC3lhIlFICh3aSVioDYv+04aT/999JUIa18ZYkdQTDKLgek1lWa+TN9U7Zd4N
 /9XA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx9nzMWApw05dKz7ybUtI3weAqV9s/vgoW3c1/3DiOBOBW7H69cVVqEgsNgk3zQIGCuxXxfpxvwUhoA@nongnu.org
X-Gm-Message-State: AFq9FYKlVoZFq16Ym6f1Rc6MfqFa3aW1RL4x/EcMVKdrpw7/aeswSRi7
 wWip01TQHo3/FcoKh2OlnYh38O+YZTf1WVLkUaab6UhcgwcUCjIZkw+HyvEIBtx62eYOjv2pLHf
 sOsGhWNLq4ipcgLGkjiTxpqcGIhSSOsSNS0oLcXDBK2FeQlU3MU9C5nMGVg==
X-Gm-Gg: AYBFou03SA+bAelFZSJnvUmvYTJfeb49pxONnOLFi5FXVsomx4apoGPTGEpIGVVq3cl
 ePVK4pteLM1/hMJkrzjr9nPEZxo3CKDYdEnK+QHpSJcmDEw2Fmg+a+zdcp/lh8PruyZBcKg5ORO
 AiR3usMUvJTK2TkiPTRDZF75zMvZDqLElSxhtq4KrklMr4Vc+UqYkpaOWmjTHHz6QgZgXtuYeXF
 Dq0z2GWw8pafxVT5qe6EwmOHuI0OowULGHHIxoJxRq0X80V5lheng+/TW4pGKkMMp32jKfJp2Vm
 tjKlgyOD3+n0hCfrz2c5sfYctPBbeVB9evsnxbdliSXo80Y5q/jtCzehuCc/Dor9ogjUoN0ZpQH
 Y5QxClBtfcbFjyns7Fy2+uRZDfbFNmc2J3w==
X-Received: by 2002:a05:620a:6844:b0:93c:5c60:c3bb with SMTP id
 af79cd13be357-93ebd271c3cmr1995875185a.62.1791880311296; 
 Tue, 13 Oct 2026 01:31:51 -0700 (PDT)
X-Received: by 2002:a05:620a:6844:b0:93c:5c60:c3bb with SMTP id
 af79cd13be357-93ebd271c3cmr1995871685a.62.1791880310545; 
 Tue, 13 Oct 2026 01:31:50 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a195002123sm355270285e9.1.2026.10.13.01.31.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 01:31:49 -0700 (PDT)
Message-ID: <c7a6df91-ceeb-4bb2-aa80-9be62568af55@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 10:31:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] hw/misc/unimp: Add
 create_unimplemented_devices() helper
Content-Language: en-US
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Ani Sinha <anisinha@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20261012064445.2571633-1-jamin_lin@aspeedtech.com>
 <20261012064445.2571633-2-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261012064445.2571633-2-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: _AgGQHAw6Dl9eBbf8T0lWM8akHMbnxN0
X-Proofpoint-ORIG-GUID: _AgGQHAw6Dl9eBbf8T0lWM8akHMbnxN0
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAzMyBTYWx0ZWRfX1/w1cKxVGbS5
 0Ucejifk2b+PpGdSTRu48sE01ueT6yijkwcjhUSN772DgqK/5dpQ6YysGEABKwIniALwo9WcmaE
 D5F1B/HUhrf5z6PNd8m9V9GsU+qzwbg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAzMyBTYWx0ZWRfXyZk2YQFalbz7
 sJX1l7QXWmjYED+GNH3MPgkguze5UDJp7mlrtBAWytCMTFDTUWlodSVazGwTR3L8Q0iFHcbQpot
 jdZhLosvcZofOZ39I+1iE9oBTjcdy0dywrozr2DvnqtVZv2Hyag061pC4iOet9dis4jkCy4CLL+
 80zwABUqrARDBcwurwZNTPcGPXXSoPuBwkmrTCr3v5Z6lclk+F6Z+11+NRJlWUuCfqke2xJ0Tas
 wqT45I/mu0Tm54EHzIXaZMVzcdvWDMH4/HkHfQd8yTtWxi/5g7MUhCMi7k/qTEbNUvomsme9WhY
 HT8j7AIfqsYq/gRJ45nA6yY39kUpBqRjhcXmK6LgfAl/a7tgjuClEGt4zxCtFq5aTZ897oyYXDX
 aWpx6zwBBJ9FKI07f+V6k/7M7c/VpJ8xCfjsGkfSHO0VadJXqEuZSLu1BVhtNmfRYlhoC0vElul
 /j4P3ol245vwgcfP9Ag==
X-Authority-Analysis: v=2.4 cv=PMGaavqC c=1 sm=1 tr=0 ts=6acdec78 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=V2NxCb60AAAA:8 a=pKi8lk0iLv7-GY_xGRUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=3L6qF29SlnrayQqPM2jZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130033
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 12/10/26 08:44, Jamin Lin wrote:
> Several boards and SoCs create many unimplemented devices. Each of them
> uses its own structure and helper to describe and map these devices.
> 
> Add an UnimplementedDeviceConfig structure and a
> create_unimplemented_devices() helper. The helper creates an
> unimplemented device for each entry of a table, adds it as a QOM child
> of the parent object, and maps it in a memory region container with
> the given priority. The table is terminated by an empty entry.
> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   include/hw/misc/unimp.h | 21 +++++++++++++++++++++
>   hw/misc/unimp.c         | 20 ++++++++++++++++++++
>   2 files changed, 41 insertions(+)

Thanks!

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

