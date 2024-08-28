Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 255D8C5474E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 07:21:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjCz0-0007Li-NR; Wed, 28 Aug 2024 03:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sjCyz-0007Kk-9i
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 03:20:45 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sjCyv-0002Vl-2L
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 03:20:44 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5a10835487fso9459796a12.1
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 00:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1724829637; x=1725434437; darn=nongnu.org;
 h=cc:to:subject:message-id:date:user-agent:references:in-reply-to
 :mime-version:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vFYD4ziIDjeJF7mJEr9KZRKnmyuzkJD2ty60MjJeveI=;
 b=MUgZg2d3w2n7kApa95cM7/nPULm3jyg9wcNWnwOyD9kBqER+m4rtM7odi+5rbhNR/L
 ydhbG9GCTfB7PoydqLU7rVLWS/E5d0mD8lgUHLanYYoZobz8pUnBkNZPsP5QL2tRG+Rn
 8qFTCH81RjnlQuSnC0LNyzheGqckQ3b8Ded9K3vJyVxAz5L+1HTdQ99dRqDe6Hk+Bp4z
 zUJzvydMNzYd+aUpnLqONdzpF5IMZu5srUJLkNPCxrmeSReSGyYTypSma9xuFPxiwuhI
 3tlXwN0U0kfFCEGitbDCnEvRuLEd/4RiQlSWeBFN3ead1Z4lTWb8gjf+5h2a/evUTL2O
 qfpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724829637; x=1725434437;
 h=cc:to:subject:message-id:date:user-agent:references:in-reply-to
 :mime-version:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vFYD4ziIDjeJF7mJEr9KZRKnmyuzkJD2ty60MjJeveI=;
 b=W5pOIpkPCGhnJ2oStO1ciBtlIzA+7PKdf0ASJYeWGf7VMzPTkwFKb1BA0CW+eRjgBF
 B2GjViP87LbMJuTl0m1I0elZ8UGiFBuhFXm9u/Dsw1etXbl2ciM8oKF3WrJDVbz/PeLc
 HeeaOf7Ha8y5HHdtxakeoi538CXcfnatjwvDRaa5lQYq0Zw05EuclH5LtSN2vzoNeja4
 eGX5yTYOZ1XdF1SXGkfklbmoLcmdTxl3nqg+wkHJ0/ekSt/ni5HmfIyNpc9kec9p9dzH
 oADbi/8T3CvT99eoUkaDejHQ1ZZl6+9ld8DqG6qhCV1Cf3ri+6G8ROHXZ7pWqay7+5ZP
 iskA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtrC52/GLBXKDiMF4QPGNyheEsIhPDucFhs449lEBQXzFRCh60kvzwKhtPfgywDQBh6iEz9isSuZ5V@nongnu.org
X-Gm-Message-State: AOJu0Yyirha3Fo7QPqoyXjk/ifR1kJs6fatupWQNfXhwvAqg7bW03fd5
 9XCXwM4w82iAYcS9o3eXOkozthqkOhgvK2KMsDXc18ulOcNAmtd+HH4MlZy24eUl12pECiIAkgv
 mcEp3sjhZ3OytQuulxOSg83+6UENcX50rz0h3aQ==
X-Google-Smtp-Source: AGHT+IGJGH/+Q9j/mi5ZAdoU9Hv2fT+60pPxjve+n3FYpFqXJoWqaB37DIU73+hB51We2NChxFwuzvpkwIwPLQM93nM=
X-Received: by 2002:a05:6402:50cf:b0:5be:ef1f:c679 with SMTP id
 4fb4d7f45d1cf-5c0891a2702mr10877617a12.23.1724829637133; Wed, 28 Aug 2024
 00:20:37 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST; 
 Wed, 28 Aug 2024 00:20:36 -0700
From: =?UTF-8?B?5Y2i6ZW/5aWH?= <luchangqi.123@bytedance.com>
X-Original-From: =?UTF-8?B?5Y2i6ZW/5aWHIDxsdWNoYW5ncWkuMTIzQGJ5dGVkYW5jZS5jb20+?=
Mime-Version: 1.0
In-Reply-To: <Zs7I3AAzsO2Xe5iG@cormorant.local>
References: <20240712023650.45626-1-luchangqi.123@bytedance.com>
 <20240712023650.45626-10-luchangqi.123@bytedance.com>
 <Zs7I3AAzsO2Xe5iG@cormorant.local>
User-Agent: Mozilla Thunderbird
Date: Wed, 28 Aug 2024 00:20:36 -0700
Message-ID: <CAO5cSZCkHCM0nrgQO4ykJ808UCxF-TEy7_0zkA3LDaZ0S8zyCg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v9 09/10] hw/nvme: add reservation protocal
 command
To: Klaus Jensen <its@irrelevant.dk>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, 
 hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net, 
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de, 
 kbusch@kernel.org, foss@defmacro.it, philmd@linaro.org, 
 pizhenwei@bytedance.com, Klaus Jensen <k.jensen@samsung.com>
Content-Type: multipart/alternative; boundary="000000000000d1e1b30620b931e0"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-ed1-x535.google.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_MUA_MOZILLA=2.309,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000d1e1b30620b931e0
Content-Type: text/plain; charset="UTF-8"

Hi,

I want to know if I understand it correctly.

```
static void nvme_aio_err(NvmeRequest *req, int ret)
{
uint16_t status = NVME_SUCCESS;
Error *local_err = NULL;

switch (req->cmd.opcode) {
case NVME_CMD_READ:
case NVME_CMD_RESV_REPORT:
status = NVME_UNRECOVERED_READ;
break;
case NVME_CMD_FLUSH:
case NVME_CMD_WRITE:
case NVME_CMD_WRITE_ZEROES:
case NVME_CMD_ZONE_APPEND:
case NVME_CMD_COPY:
case NVME_CMD_RESV_REGISTER:
case NVME_CMD_RESV_ACQUIRE:
case NVME_CMD_RESV_RELEASE:
status = NVME_WRITE_FAULT;
break;
default:
status = NVME_INTERNAL_DEV_ERROR;
break;
}

trace_pci_nvme_err_aio(nvme_cid(req), strerror(-ret), status);

error_setg_errno(&local_err, -ret, "aio failed");
error_report_err(local_err);

/*
* Set the command status code to the first encountered error but
allow a
* subsequent Internal Device Error to trump it.
*/
if (req->status && status != NVME_INTERNAL_DEV_ERROR) {
return;
}

req->status = status;
}
```
In the above use case, if it is a pr-related command and the error code
is not supported, the invalid error code should be returned instead of
the Fault error code.


On 2024/8/28 14:51, Klaus Jensen wrote:
> On Jul 12 10:36, Changqi Lu wrote:
>> Add reservation acquire, reservation register,
>> reservation release and reservation report commands
>> in the nvme device layer.
>>
>> By introducing these commands, this enables the nvme
>> device to perform reservation-related tasks, including
>> querying keys, querying reservation status, registering
>> reservation keys, initiating and releasing reservations,
>> as well as clearing and preempting reservations held by
>> other keys.
>>
>> These commands are crucial for management and control of
>> shared storage resources in a persistent manner.
>> Signed-off-by: Changqi Lu
>> Signed-off-by: zhenwei pi
>> Acked-by: Klaus Jensen
>> ---
>> hw/nvme/ctrl.c | 318 +++++++++++++++++++++++++++++++++++++++++++
>> hw/nvme/nvme.h | 4 +
>> include/block/nvme.h | 37 +++++
>> 3 files changed, 359 insertions(+)
>>
>
>> +static uint16_t nvme_resv_register(NvmeCtrl *n, NvmeRequest *req)
>> +{
>> + int ret;
>> + NvmeKeyInfo key_info;
>> + NvmeNamespace *ns = req->ns;
>> + uint32_t cdw10 = le32_to_cpu(req->cmd.cdw10);
>> + bool ignore_key = cdw10 >> 3 & 0x1;
>> + uint8_t action = cdw10 & 0x7;
>> + uint8_t ptpl = cdw10 >> 30 & 0x3;
>> + bool aptpl;
>> +
>> + switch (ptpl) {
>> + case NVME_RESV_PTPL_NO_CHANGE:
>> + aptpl = (ns->id_ns.rescap & NVME_PR_CAP_PTPL) ? true : false;
>> + break;
>> + case NVME_RESV_PTPL_DISABLE:
>> + aptpl = false;
>> + break;
>> + case NVME_RESV_PTPL_ENABLE:
>> + aptpl = true;
>> + break;
>> + default:
>> + return NVME_INVALID_FIELD;
>> + }
>> +
>> + ret = nvme_h2c(n, (uint8_t *)&key_info, sizeof(NvmeKeyInfo), req);
>> + if (ret) {
>> + return ret;
>> + }
>> +
>> + switch (action) {
>> + case NVME_RESV_REGISTER_ACTION_REGISTER:
>> + req->aiocb = blk_aio_pr_register(ns->blkconf.blk, 0,
>> + key_info.nr_key, 0, aptpl,
>> + ignore_key, nvme_misc_cb,
>> + req);
>> + break;
>> + case NVME_RESV_REGISTER_ACTION_UNREGISTER:
>> + req->aiocb = blk_aio_pr_register(ns->blkconf.blk, key_info.cr_key, 0,
>> + 0, aptpl, ignore_key,
>> + nvme_misc_cb, req);
>> + break;
>> + case NVME_RESV_REGISTER_ACTION_REPLACE:
>> + req->aiocb = blk_aio_pr_register(ns->blkconf.blk, key_info.cr_key,
>> + key_info.nr_key, 0, aptpl, ignore_key,
>> + nvme_misc_cb, req);
>> + break;
>
> There should be some check on rescap I think. On a setup without
> reservation support from the block layer, these functions ends up
> returning ENOTSUP which causes hw/nvme to end up returning a Write Fault
> (which is a little wonky).
>
> Should they return invalid field, invalid opcode?

--000000000000d1e1b30620b931e0
Content-Type: text/html; charset="UTF-8"

<p>Hi,
<br>
<br>I want to know if I understand it correctly.
<br>
<br>```
<br>static void nvme_aio_err(NvmeRequest *req, int ret)
<br>{
<br>    uint16_t status = NVME_SUCCESS;
<br>    Error *local_err = NULL;
<br>
<br>    switch (req-&gt;cmd.opcode) {
<br>    case NVME_CMD_READ:
<br>    case NVME_CMD_RESV_REPORT:
<br>        status = NVME_UNRECOVERED_READ;
<br>        break;
<br>    case NVME_CMD_FLUSH:
<br>    case NVME_CMD_WRITE:
<br>    case NVME_CMD_WRITE_ZEROES:
<br>    case NVME_CMD_ZONE_APPEND:
<br>    case NVME_CMD_COPY:
<br>    case NVME_CMD_RESV_REGISTER:
<br>    case NVME_CMD_RESV_ACQUIRE:
<br>    case NVME_CMD_RESV_RELEASE:
<br>        status = NVME_WRITE_FAULT;
<br>        break;
<br>    default:
<br>        status = NVME_INTERNAL_DEV_ERROR;
<br>        break;
<br>    }
<br>
<br>    trace_pci_nvme_err_aio(nvme_cid(req), strerror(-ret), status);
<br>
<br>    error_setg_errno(&amp;local_err, -ret, &quot;aio failed&quot;);
<br>    error_report_err(local_err);
<br>
<br>    /*
<br>     * Set the command status code to the first encountered error but
<br>allow a
<br>     * subsequent Internal Device Error to trump it.
<br>     */
<br>    if (req-&gt;status &amp;&amp; status != NVME_INTERNAL_DEV_ERROR) {
<br>        return;
<br>    }
<br>
<br>    req-&gt;status = status;
<br>}
<br>```
<br>In the above use case, if it is a pr-related command and the error code
<br>is not supported, the invalid error code should be returned instead of
<br>the Fault error code.
<br>
<br>
<br>On 2024/8/28 14:51, Klaus Jensen wrote:
<br>&gt; On Jul 12 10:36, Changqi Lu wrote:
<br>&gt;&gt; Add reservation acquire, reservation register,
<br>&gt;&gt; reservation release and reservation report commands
<br>&gt;&gt; in the nvme device layer.
<br>&gt;&gt;
<br>&gt;&gt; By introducing these commands, this enables the nvme
<br>&gt;&gt; device to perform reservation-related tasks, including
<br>&gt;&gt; querying keys, querying reservation status, registering
<br>&gt;&gt; reservation keys, initiating and releasing reservations,
<br>&gt;&gt; as well as clearing and preempting reservations held by
<br>&gt;&gt; other keys.
<br>&gt;&gt;
<br>&gt;&gt; These commands are crucial for management and control of
<br>&gt;&gt; shared storage resources in a persistent manner.
<br>&gt;&gt; Signed-off-by: Changqi Lu 
<br>&gt;&gt; Signed-off-by: zhenwei pi 
<br>&gt;&gt; Acked-by: Klaus Jensen 
<br>&gt;&gt; ---
<br>&gt;&gt;  hw/nvme/ctrl.c       | 318 +++++++++++++++++++++++++++++++++++++++++++
<br>&gt;&gt;  hw/nvme/nvme.h       |   4 +
<br>&gt;&gt;  include/block/nvme.h |  37 +++++
<br>&gt;&gt;  3 files changed, 359 insertions(+)
<br>&gt;&gt;
<br>&gt; 
<br>&gt;&gt; +static uint16_t nvme_resv_register(NvmeCtrl *n, NvmeRequest *req)
<br>&gt;&gt; +{
<br>&gt;&gt; +    int ret;
<br>&gt;&gt; +    NvmeKeyInfo key_info;
<br>&gt;&gt; +    NvmeNamespace *ns = req-&gt;ns;
<br>&gt;&gt; +    uint32_t cdw10 = le32_to_cpu(req-&gt;cmd.cdw10);
<br>&gt;&gt; +    bool ignore_key = cdw10 &gt;&gt; 3 &amp; 0x1;
<br>&gt;&gt; +    uint8_t action = cdw10 &amp; 0x7;
<br>&gt;&gt; +    uint8_t ptpl = cdw10 &gt;&gt; 30 &amp; 0x3;
<br>&gt;&gt; +    bool aptpl;
<br>&gt;&gt; +
<br>&gt;&gt; +    switch (ptpl) {
<br>&gt;&gt; +    case NVME_RESV_PTPL_NO_CHANGE:
<br>&gt;&gt; +        aptpl = (ns-&gt;id_ns.rescap &amp; NVME_PR_CAP_PTPL) ? true : false;
<br>&gt;&gt; +        break;
<br>&gt;&gt; +    case NVME_RESV_PTPL_DISABLE:
<br>&gt;&gt; +        aptpl = false;
<br>&gt;&gt; +        break;
<br>&gt;&gt; +    case NVME_RESV_PTPL_ENABLE:
<br>&gt;&gt; +        aptpl = true;
<br>&gt;&gt; +        break;
<br>&gt;&gt; +    default:
<br>&gt;&gt; +        return NVME_INVALID_FIELD;
<br>&gt;&gt; +    }
<br>&gt;&gt; +
<br>&gt;&gt; +    ret = nvme_h2c(n, (uint8_t *)&amp;key_info, sizeof(NvmeKeyInfo), req);
<br>&gt;&gt; +    if (ret) {
<br>&gt;&gt; +        return ret;
<br>&gt;&gt; +    }
<br>&gt;&gt; +
<br>&gt;&gt; +    switch (action) {
<br>&gt;&gt; +    case NVME_RESV_REGISTER_ACTION_REGISTER:
<br>&gt;&gt; +        req-&gt;aiocb = blk_aio_pr_register(ns-&gt;blkconf.blk, 0,
<br>&gt;&gt; +                                         key_info.nr_key, 0, aptpl,
<br>&gt;&gt; +                                         ignore_key, nvme_misc_cb,
<br>&gt;&gt; +                                         req);
<br>&gt;&gt; +        break;
<br>&gt;&gt; +    case NVME_RESV_REGISTER_ACTION_UNREGISTER:
<br>&gt;&gt; +        req-&gt;aiocb = blk_aio_pr_register(ns-&gt;blkconf.blk, key_info.cr_key, 0,
<br>&gt;&gt; +                                         0, aptpl, ignore_key,
<br>&gt;&gt; +                                         nvme_misc_cb, req);
<br>&gt;&gt; +        break;
<br>&gt;&gt; +    case NVME_RESV_REGISTER_ACTION_REPLACE:
<br>&gt;&gt; +        req-&gt;aiocb = blk_aio_pr_register(ns-&gt;blkconf.blk, key_info.cr_key,
<br>&gt;&gt; +                                         key_info.nr_key, 0, aptpl, ignore_key,
<br>&gt;&gt; +                                         nvme_misc_cb, req);
<br>&gt;&gt; +        break;
<br>&gt; 
<br>&gt; There should be some check on rescap I think. On a setup without
<br>&gt; reservation support from the block layer, these functions ends up
<br>&gt; returning ENOTSUP which causes hw/nvme to end up returning a Write Fault
<br>&gt; (which is a little wonky).
<br>&gt; 
<br>&gt; Should they return invalid field, invalid opcode?</p>

--000000000000d1e1b30620b931e0--

