Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1636FC5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 12:44:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzCzF-00037N-ME; Wed, 26 Aug 2026 08:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzCzE-00036g-4K
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 08:44:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzCzC-0007xF-Fs
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 08:44:11 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QCUFs0949259
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 12:44:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 s58jf6Nc2WMgJi0j/JyqhhLO9k4sPC4tHKSvMN4XBuo=; b=Vl/KsO23myk1qhD/
 dzHvsqH79Ae6rqQLRC5A6tEQpii7SAuBhcxa4GCM4GYcUWZEo83iz7/2STI3jJON
 ob0Q0Gll4hSZ4HPLC3fsvB0ufaX6XOWLOck0hAM4mzvKtQCxuaa/VdxO99Yq4N+j
 ZgtEdy0LFuzrnn4LCbVbzp1Aiyip2I66aOLXMLNg8ohDJxbPpdre0JPog7Yrpyb7
 XyX55F73oCTxF/0BDvGS6/axIa9ic6K+/dUrdvNHDdw+DoK6bolSVH+xPsQqN/Iw
 l25cl2Boh1sZJMoR1l8+p6v0QiTEmGaqTlzLBuw74vwqcSerZafbh7GQg4oy4Zxn
 ByXzrw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga07581mt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 12:44:08 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92ef13b61bcso127679585a.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 05:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787748248; x=1788353048; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=s58jf6Nc2WMgJi0j/JyqhhLO9k4sPC4tHKSvMN4XBuo=;
 b=PltAYyjkJ/XObupOlXwZqhpV9qWMA4F0isgIVpUexo7nMkjWE6knN/xX0IHkZFjarN
 Au1b5+R8UKo9BUf/XWjT0XS6tMUowq+Y1/zWEvmQIiCI/Qo5Xk9W0RZyPEBAuNm23BZ3
 S83RN45xlyjvMnTbtHECQqYT261/D6mGF7OlrxeMlSUhWa5oArnLPfRbw5oqVCRKFe7p
 Yf3h2g+bpz+04b07NuwiMKu2u/ESEDTcZUHoJfBncFXONbvyJ+R51uydE1f8Z06UfNi4
 JApqOj7jsTTHX+v8Q+lQP1VJnGqoUN0rsN1u0tdyaFCnUXV/vXi4Gd+OFYyl7W34XqtG
 NKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787748248; x=1788353048;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s58jf6Nc2WMgJi0j/JyqhhLO9k4sPC4tHKSvMN4XBuo=;
 b=O8a6A36X94rGuqmoq/A/W8fFKQ4d/OZ+wQg+DFNHso/pTuvED44h+fZaomrDBDLyz4
 8fsL7X0JUoBZXilEfF27ahArjAn0wCq7i3kjQbJo9H9tp8Qdwsdv+XH8gVBedrsrV4AR
 GtxOgHALtg1V/IAsU7fFMFvUb3lDZSWjpyjgt3fkCiEK48/dYNo202cTSV3tm4MBmxms
 oLXWaejkgj9dhgfcapGRRZ4xUnLSbqTznOzVBF1/UFGDAdJ/eexMyMahoLKOrxHaiNWs
 NozDYh2GumZh4aJ2cl5UT8E0lU+on3cx896HL4+88dTff8441SiUsUOeQ2IdtIQ2oTey
 7VFg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqHYBQxJS4sDXwk1vvwcEcEWVsv/qv2LwXWgGVc/GRrqB3EfrgBZBfUCEseraD8UYbA+jpO3v9V6DD/@nongnu.org
X-Gm-Message-State: AFuF++n1o63WPqvycoAzCXo638YwnRHoIhMgqd4wUxAxRaplJV9jx8Si
 Oe9rkDIcQiqO11NnOrPgG84niLatvukdYAW7AkouPP2EvwbbAwLJe5DiFb/pIRi4L9Nfokp9oEa
 rLLT9ez3DzWyhAY7eUas9GT7Gskvr3kG8144IhakQj+TFCFZAc95SwXZ5YQ==
X-Gm-Gg: AR+sD13hGf3Sy/y+fViTUZrfM3viiv6xaAuKiwYgMPw/20ZxgopbTh+i1WRyB7mp8l6
 PaCAk2gFCIE3opruFc4ZGKg/+mvzoy20oR2uLhR2sD14m1NizDpIWhuqLBbAm1BdjfDFqThkWMO
 2UItM5acS3J6ncjb3PTLGFYCtGqM3WgEMfyx1F4ZJhEAmsJE9SPfl13a5xYOrvLs3p7gIoPLt4X
 L/elqj9Hmusa0i+Q5X8TwzGDfuaKqG8OVaZQdLljo5b2+CU9mLCWd/UkWn67Qcb8pavy6+8h5/Q
 5scKxCLLA18Xtmw+ArLXel82WKi4OAho5gaKzk2WvK+/AGfk3Pbh2bemxJEvvQ/thGM99hsGCrF
 ueu+Rl19MydVY22uSZebL
X-Received: by 2002:a05:622a:1c0c:b0:51c:d52:6049 with SMTP id
 d75a77b69052e-52e4240639emr68465201cf.28.1787748247644; 
 Wed, 26 Aug 2026 05:44:07 -0700 (PDT)
X-Received: by 2002:a05:622a:1c0c:b0:51c:d52:6049 with SMTP id
 d75a77b69052e-52e4240639emr68464171cf.28.1787748247163; 
 Wed, 26 Aug 2026 05:44:07 -0700 (PDT)
Received: from [10.254.188.74] ([185.104.138.96])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a88ac5csm490938066b.40.2026.08.26.05.44.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 05:44:06 -0700 (PDT)
Message-ID: <ec58e02f-6ced-4910-94af-0aac76b010bb@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 14:43:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 21/49] block: add x-qemu-io QMP command
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: dave@treblig.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
 <20260825-qemu-no-hmp-v4-21-af60857c2fbe@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260825-qemu-no-hmp-v4-21-af60857c2fbe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: H3hMfdelwCt2c5KklnR6DtRe-vaCOoWW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEwNSBTYWx0ZWRfX3RG6YVDLM7I5
 0yVOK+/dDSWerTVZjuNcIN8qCKSpCABtUzX4XErFT2JqeotZcfmxbmW3WjKjGiDhjPlWv6rsELf
 146lH1N271BAsqvr/Lxme9HUpjwDKe2fRyRD7BMGqd5bcSTka0IMR2bHpy9Snetg6zJh0Wdj8ua
 LgunuCO4z9SQSJFcOghK59sIeTr3RwO8OOKvFLqhtN3SHP8zE1HpUWxP0uUwSMU8tcWHPTslCY+
 Ejck23vgfSaWuQzaTdGMkTwd0Mw0XppL1e9YKHn7Yx4o9Bq7Mnougrxneh0Md1nzxNsQoMzqX28
 YqASBT5MOZ+UmxYPoNXtXhcnPARdq0yOWWYU0eHV+A8I8nq2iAoNzOAP/NWxK8rDWfBpcyHSizq
 paxFKbObjE3wHZoyrS2jeM/DF8EmeNHMORgMuHDiImyWgMJTFIQzExFuwk1Ele8gEtLAIYpIomD
 hbaJIdOHaUkr8U6+ssw==
X-Proofpoint-GUID: H3hMfdelwCt2c5KklnR6DtRe-vaCOoWW
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEwNSBTYWx0ZWRfX1RcTkwIXWJ1K
 a3BQlxgLZ3q63EhOBvtq3t9sF7bT4bkt4ZSs120VZfm8h8vmrBVmkRFjx+CJGUTouL7/bpCy9/K
 4k46L0lZDfGbXXkR55ka9Wd0GeJMKK4=
X-Authority-Analysis: v=2.4 cv=RPiD2Yi+ c=1 sm=1 tr=0 ts=6a8edf98 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=KRlTYBX1Q8J3JuxqD7zILw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=20KFwNOVAAAA:8 a=NcbwogP7gQwllQR3uYsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260105
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

On 25/8/26 21:09, Marc-AndrÃ© Lureau wrote:
> Add an x-qemu-io QMP command that runs qemu-io commands on block
> devices. The command accepts a device name (block backend name,
> node-name, or qdev ID) and a qemu-io command string.
> 
> Refactor hmp_qemu_io() to be a thin wrapper around the new QMP
> command, following the standard HMP-over-QMP pattern used by other
> block commands.
> 
> This change is also required for the qtest qemu-io command in the
> following patch.
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   block/monitor/block-hmp-cmds.c | 60 ++------------------------------
>   block/monitor/meson.build      |  1 +
>   block/monitor/qmp-cmds.c       | 79 ++++++++++++++++++++++++++++++++++++++++++
>   qapi/block.json                | 34 ++++++++++++++++++
>   4 files changed, 117 insertions(+), 57 deletions(-)


> diff --git a/qapi/block.json b/qapi/block.json
> index 46955bbb3e34..012a9d73333b 100644
> --- a/qapi/block.json
> +++ b/qapi/block.json
> @@ -603,3 +603,37 @@
>              '*boundaries-zap': ['uint64'],
>              '*boundaries-flush': ['uint64'] },
>     'allow-preconfig': true }
> +
> +##
> +# @x-qemu-io:
> +#
> +# Run a qemu-io command on a block device.  Take either a block
> +# backend name or a qdev ID to identify the device.
> +#
> +# @device: the block backend name, node-name to run the
> +#     command on.
> +#
> +# @qdev: the qdev ID of the block device to run the
> +#     command on.
> +#
> +# @command: the qemu-io command string to execute.
> +#
> +# Features:
> +#
> +# @unstable: This command is for testing only.
> +#
> +# Since: 11.2
> +#
> +# .. qmp-example::
> +#
> +#     -> { "execute": "x-qemu-io",
> +#          "arguments": { "device": "virtio0",
> +#                         "command": "read 0 512" } }
> +#     <- { "return": {} }
> +##
> +{ 'command': 'x-qemu-io',
> +  'data': { '*device': 'str',
> +            '*qdev': 'str',
> +            'command': 'str' },
> +  'features': [ 'unstable' ],
> +  'allow-preconfig': true }

'qemu-io' HMP command was a bad name decision. This is a good
opportunity to clean it: can we add QMP 'x-block-io' or
'x-block-cmd' / 'x-block-command' instead? Keeping the legacy
HMP name (or adding an HMP alias)?


