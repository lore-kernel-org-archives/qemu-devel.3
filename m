Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98130C4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 10:14:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm7Up-0001fw-VO; Tue, 21 Jul 2026 06:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm7Un-0001dE-St
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 06:14:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm7Um-00080X-C3
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 06:14:41 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66L892BI091469
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 10:14:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fUNsulcXPHtShdXbNajyYdwjb37qg0DQjPJOlx2/+Zk=; b=dNmZiPh1UD9Hf6xl
 xiVsQCzX258s/GhJWkwgOoCKiD1Disz7CYhzYeWYSXiU3yAkzaSBXgbso5NBEZi/
 8hpZrw/KOA3x6pkkWoKPc+sO/YYIRZMGbVkWdz/6LVwi0ngL3+DyjdzjMXmdVoq7
 +8JLpGjqMY35olVVJDTnpNCqMhdc7A7r5gypBcRSRX11CWusISlEpVwGA7Y5iFC5
 H5M+ot0uTbJS+W/gG9BpV7VafA5mCMKsjE+6EDvIGjsMRjjJvPZJ0TJ8LdVw6Rwb
 06RuUTin2CMUc+kyLn7h0KQP5FP91aJmFU+Qo3jOM2P4G3kDaNHbFRmQTYIZafKr
 D+5iBQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj01aa1ex-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 10:14:38 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-9077b4c35c5so111635366d6.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 03:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784628878; x=1785233678; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fUNsulcXPHtShdXbNajyYdwjb37qg0DQjPJOlx2/+Zk=;
 b=USKaaw+Wf1zPd1h3GoTS17oaR5tWq4hVRsA6F2UVrzV6s3IjGZPPoXXpJwQMKj66Y9
 5L5eder85ldayqEKo0F9WZT3uFPP179HGZKKHvLsXEG61fZBimiQb0qv0TQ5LDFyxmK0
 +NWeak03aX/5rlnu2UYjnKneAGxP4oBMZB9eniwUAqNlghJx3a+8EJPtC4r1FHj273wP
 sqP3PKZV18FI0wYesnXH58s2mWfCBkL5UJGAw8njgdd0it8IZty3jBaNPUIQIM6WRtiB
 QTk7z9HvnS6PXAeRyepstSK763/dUGJLvqMYScvxjDYngvuCFTOy9StVO6MNMxNH6Swc
 ODvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784628878; x=1785233678;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fUNsulcXPHtShdXbNajyYdwjb37qg0DQjPJOlx2/+Zk=;
 b=FNoCWxHsO3v7ZM6B85LLyMZ0a143VBT9ncvaX+ZG8BuPXDDZksOp4JH79XwwrwdQXd
 ImRlK/8n1TsuChmv53pLW0NHs5CACTgzaqjocSYOICXsuScXwJ7z4H0GUm3+QFqUXaHZ
 oXkr7lm0nWUaKT+EZdtqJvIJNleP8pu6txPfqLzTz8WH/tQuHvqAjKKQIWMpNnhQL92m
 IuJhRZHJeR7DNeEivZLHKxGAIXSvuxk8TgyG11Wm1rwcL7M/9zHWp0F5zlwviz/sgidu
 TM8MOo5MjscjHnX2ikK8dcfz6dwOzZ0ppZ0hLUFRspjmeBPzld2iZqFYm8c2yxEDqzjh
 yB3w==
X-Forwarded-Encrypted: i=1;
 AHgh+RqSo0SpHo33/C8IkZsdqkELmeZD+pG1MrAD46+xru65KRkhMxOXtM9kf3JyNMEPScjgiGEedXgzfeu9@nongnu.org
X-Gm-Message-State: AOJu0YwuUnlzWkvmLPT+v9UmFZiz5/AYJ2rDi5/2M5V+gb4MihHkjUYx
 k2iN5QQEm6M/FobA+KHQM6U880YO2UrczZtXcgd1PMdqQr9swkC0n9V+d+2Uhe2o/Bo5qC+m2Bj
 +j3xrNsTYJ2kbDYcV4vb0j8xkKfC7Na4P/ZThQwrCAfBcvKzHCU40nM0dqQ==
X-Gm-Gg: AfdE7cmMxgNJyypXYug3J4l/wVwaiBPg2rFKwXLnBkUnfY1foRAHRl7EdI879pSJWKc
 gFIzCOb1nueIuWY7wRKcYK6tn6KKjLVACTV8W36RPlPSROb7QOqEeCPsiSpnRPmHWIOUEcr7cDu
 FnIGn4vfhDC5IDeTAReF45joKBZ+VNJi2Jhrw9hr7uQIZmXR7nT3P0FWkpD7CKT8gxIepEKKdmL
 7FAE1lKOpbGxMM8PqEIhV1YvrqvK4MNzd6oauoZF/83k5kQ0F8yAo/uO9HYSfrLukx3WCijXPmn
 XtRf51L/3eM/s87OjEa1zCybem12d3TtBo6nO88D6DCujxvGDDJXLG+G+nFKy0IETnkVop+vEKS
 Ru8h+1v+E+0Ip8XW+ADEbglAZhD9myuIglpe+wb2s3dXRVI70UJQ=
X-Received: by 2002:ac8:59c5:0:b0:51c:de5:bd4b with SMTP id
 d75a77b69052e-5213a385922mr169585811cf.16.1784628877642; 
 Tue, 21 Jul 2026 03:14:37 -0700 (PDT)
X-Received: by 2002:ac8:59c5:0:b0:51c:de5:bd4b with SMTP id
 d75a77b69052e-5213a385922mr169585521cf.16.1784628877189; 
 Tue, 21 Jul 2026 03:14:37 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63ee0086sm40682241f8f.30.2026.07.21.03.14.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 03:14:36 -0700 (PDT)
Message-ID: <ede1aa2e-5e39-4c7e-8104-77535a097160@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 12:14:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] replay: fix use of uninitialized pointer on error
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20260719113216.1177594-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260719113216.1177594-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=BL6DalQG c=1 sm=1 tr=0 ts=6a5f468e cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=20KFwNOVAAAA:8 a=I1jNWL3L5KlrVf5Vk-QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDEwOCBTYWx0ZWRfX3NsV2RUWtPi+
 fHXHmJ1EelH2JvBrMWQ/gGMF3bcPTAlGXonz6f964M3hi+2n4yl0e1OUnurzwTxGbm7qRxRUJnx
 l8k3EOq7g/L8extxfPBSWuxoV/NwYh1/EQN0CRzNrnC/SloqREF6nGwtDg48/kUEi+pUUXOLouM
 gG5zuISTwxXZj5d4DCchAkvdS57qCKP0lv1HwQRzKZ8DeMLlYv65f1DLBqMdnXDTWig7oWeyTr6
 7iGvMDNDlr1QI2OzwvlxMjYYv+DA9YW0yq7R3P3EZ0cpmQ5FA66JadQpIiHNsl2TgrxMqf1cDEH
 9nYrHvrpFKyM8514979tujP38abxxYpGTloWay8yTaNmnfUkdMjOHeafiJ/puwvXTKoupmM3j0P
 O1DA1zYp1w67ilB+IKcxsTQapj99YKRNr3rHgR5/FerKj95c/03P0nfJQZFAl24mapzb4H9vplD
 mumAZOaBowaGn+Em1yA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDEwOCBTYWx0ZWRfX0DjSmUmMDk2W
 +mRQQSu/XhJ5mi909cu7i6+7eWRB0+h73/BMMbmoi6Paw+mwObFO01NIvB0kNmL9UoJTLweZURT
 cBpzc+PbiRT47dTjmprMpJzn+7+zmrE=
X-Proofpoint-ORIG-GUID: M8rcIFCK7xJTaVJqCvcYOpoWPQOFG-sD
X-Proofpoint-GUID: M8rcIFCK7xJTaVJqCvcYOpoWPQOFG-sD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210108
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 19/7/26 13:32, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> When bdrv_snapshot_list() returns a negative error code, sn_tab is
> uninitialized. The loop does not execute (since i=0 < negative is
> false), but the code falls through to g_free(sn_tab) which frees
> an uninitialized pointer.
> 
> Fixes: f6baed3d1485 ("replay: implement replay-seek command")
> Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
> ---
>   replay/replay-debugging.c | 23 ++++++++++++-----------
>   1 file changed, 12 insertions(+), 11 deletions(-)

Patch queued, thanks.

