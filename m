Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56816C5472D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 06:28:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjC9n-0000wf-Mv; Wed, 28 Aug 2024 02:27:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sjC9m-0000vg-8K
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 02:27:50 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sjC9j-0005H0-NJ
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 02:27:50 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2ef27bfd15bso63520051fa.2
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 23:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1724826460; x=1725431260; darn=nongnu.org;
 h=cc:to:subject:message-id:date:mime-version:user-agent:from
 :references:in-reply-to:from:to:cc:subject:date:message-id:reply-to;
 bh=I83Qgu4ZdxpCcgkLl6EHwlxD/sGZbyf4u5rvmEQW3Ck=;
 b=kFzlBtcOGO/WGfzuC4KX0HOtuzTKOqg1i6i9pD9zRniNskVXoXgl0dS+7H9bI3xC8l
 Qlj/qLUr2RD9pCQakTkyowR4Nd/3oh5vNmUbRyS5EFf1NU3emQopqwtmml0vzzlGkFSp
 TNYfedZo/anTTPyAlsbanTVKMhapk2JS4wBN0HXv97IaT08KwBauAQs9WMsnr4Y4fNM4
 ou3rBNeGo/0zHh3B9zj61ejinGOTdFi7uVGYsur3f4gk9q3o+2M2G5CtCF6AvmxmjFWZ
 9XQ3R5CauSv0Ejp0bW9Ab50MnG06K2+I88XKVrTPsCeTD2SuJT0U66AcyDpikdcnaXyr
 0LcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724826460; x=1725431260;
 h=cc:to:subject:message-id:date:mime-version:user-agent:from
 :references:in-reply-to:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I83Qgu4ZdxpCcgkLl6EHwlxD/sGZbyf4u5rvmEQW3Ck=;
 b=ls7TQaNHHnCpArxIiNHSbs7/PJmhUNouvlKh5i4hZqW0EoCQ0A62sVi9M3ePNy5ael
 z+y2qLkdiRHatLmDfGWe9NU8YA2YyB1YZyKfaMjdU1XEXM7OWni6WbBnVwDS+0md5ReS
 XlToIezCU7ahUccJswswrVYyb8GKQw+4R8YInhoJ+sLju6JJg3JNaytH7WS2eeJ+2ClU
 jPR3woqqb0oXfeFjUWl02yNE98We9H91yApsUKDvpO3gjblh6whNh9MUbwu9MfvBQ89D
 p4tmSyZ4KBcD+z01qqrDD/4/18JpzHhP6r8USNr1ArWSlU7DO6Qe2KVPiZiitH/jtYmC
 Uazw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtJOc4YbZdgk9V1bLGhhA9Gmp54IpZ15zLf/lABGB9iLupC3O3BBU45luNAk1uF9LciWD2U5LdIRfT@nongnu.org
X-Gm-Message-State: AOJu0YyCd3N+QR0V6BFMLk07aoItqnEAAkSyovXOnTI8jBfoAJhQ3Spd
 fvThmxcB6OCrJ3PCcDOIxEaoMe6geiVly0B89nwjlahIu1xLG7xxYK+xkNho5frTMzW5lz2zMeT
 5b1pnfRLXQSbRn7X4DpXcPq0D5DN9tUMVkSn3iw==
X-Google-Smtp-Source: AGHT+IH5OTeZxw91OUrp3E1kTtisorz8hLNo86TETIOcSbFHWEZgM9p8VLJzmKUhp5mmHfpJprWl5KAc+Qrwl625I3o=
X-Received: by 2002:a2e:f11:0:b0:2ef:2cbc:9072 with SMTP id
 38308e7fff4ca-2f561845cbemr4886111fa.49.1724826459736; Tue, 27 Aug 2024
 23:27:39 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST; 
 Wed, 28 Aug 2024 06:27:39 +0000
In-Reply-To: <Zs6_YDFJOmEvPTAT@cormorant.local>
References: <20240712023650.45626-1-luchangqi.123@bytedance.com>
 <20240712023650.45626-10-luchangqi.123@bytedance.com>
 <Zs6_YDFJOmEvPTAT@cormorant.local>
From: =?UTF-8?B?5Y2i6ZW/5aWH?= <luchangqi.123@bytedance.com>
User-Agent: Mozilla Thunderbird
X-Original-From: =?UTF-8?B?5Y2i6ZW/5aWHIDxsdWNoYW5ncWkuMTIzQGJ5dGVkYW5jZS5jb20+?=
Mime-Version: 1.0
Date: Wed, 28 Aug 2024 06:27:39 +0000
Message-ID: <CAO5cSZCzBFeNq7_=a+6A5rcrKE1gNm+QSDtXBAu37ZYE1KLPWA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v9 09/10] hw/nvme: add reservation protocal
 command
To: Klaus Jensen <its@irrelevant.dk>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, 
 hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net, 
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de, 
 kbusch@kernel.org, foss@defmacro.it, philmd@linaro.org, 
 pizhenwei@bytedance.com, Klaus Jensen <k.jensen@samsung.com>
Content-Type: multipart/alternative; boundary="0000000000006ef99a0620b87482"
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-lj1-x236.google.com
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

--0000000000006ef99a0620b87482
Content-Type: text/plain; charset="UTF-8"

Hi,

Thanks for your advice.
Previously, g_malloc0 was used, but a segmentation
fault occurred during testing. Later, debugging
revealed that a field in struct NvmeReservationStatusExt,
struct NvmeRegisteredCtrlExt regctl_eds[], was a
variable-length array. Therefore, g_malloc was used
to apply after the array length was determined.
Therefore, g_malloc0 was not used here.

On 2024/8/28 14:10, Klaus Jensen wrote:
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
>> +static int nvme_read_reservation_cb(NvmeReadReservation *reservation)
>> +{
>> + int rc;
>> + NvmeReservationStatus *nvme_status;
>> + NvmeRequest *req = reservation->req;
>> + NvmeCtrl *n = req->sq->ctrl;
>> + NvmeResvKeys *keys_info = reservation->keys_info;
>> + int len = sizeof(NvmeReservationStatusHeader) +
>> + sizeof(NvmeRegisteredCtrl) * keys_info->num_keys;
>> +
>> + nvme_status = g_malloc(len);
>> + nvme_status->header.gen = reservation->generation;
>> + nvme_status->header.rtype = block_pr_type_to_nvme(reservation->type);
>> + nvme_status->header.regctl = keys_info->num_keys;
>> + for (int i = 0; i < keys_info->num_keys; i++) {
>> + nvme_status->regctl_ds[i].cntlid = nvme_ctrl(req)->cntlid;
>> + nvme_status->regctl_ds[i].rkey = keys_info->keys[i];
>> + nvme_status->regctl_ds[i].rcsts = keys_info->keys[i] ==
>> + reservation->key ? 1 : 0;
>> + /* hostid is not supported currently */
>> + memset(&nvme_status->regctl_ds[i].hostid, 0, 8);
>> + }
>> +
>> + rc = nvme_c2h(n, (uint8_t *)nvme_status, len, req);
>> + g_free(nvme_status);
>> + return rc;
>> +}
>> +
>> +static int nvme_read_reservation_ext_cb(NvmeReadReservation
*reservation)
>> +{
>> + int rc;
>> + NvmeReservationStatusExt *nvme_status_ext;
>> + NvmeRequest *req = reservation->req;
>> + NvmeCtrl *n = req->sq->ctrl;
>> + NvmeResvKeys *keys_info = reservation->keys_info;
>> + int len = sizeof(NvmeReservationStatusHeader) +
>> + sizeof(uint8_t) * 40 +
>> + sizeof(NvmeRegisteredCtrlExt) * keys_info->num_keys;
>> +
>> + nvme_status_ext = g_malloc(len);
>
> This leaks heap memory due to uninitialized reserved fields in
> NvmeReservationStatusExt. Prefer g_malloc0.
>
> The one above in nvme_read_reservation_cb looks safe, but prefer
> g_malloc0 there anyway.
>
>> + nvme_status_ext->header.gen = cpu_to_be32(reservation->generation);
>> + nvme_status_ext->header.rtype =
block_pr_type_to_nvme(reservation->type);
>> + nvme_status_ext->header.regctl = cpu_to_be16(keys_info->num_keys);
>> +
>> + for (int i = 0; i < keys_info->num_keys; i++) {
>> + uint16_t ctnlid = nvme_ctrl(req)->cntlid;
>> + nvme_status_ext->regctl_eds[i].cntlid = cpu_to_be16(ctnlid);
>> + nvme_status_ext->regctl_eds[i].rkey = cpu_to_be64(keys_info->keys[i]);
>> + nvme_status_ext->regctl_eds[i].rcsts = keys_info->keys[i] ==
>> + reservation->key ? 1 : 0;
>> + /* hostid is not supported currently */
>> + memset(&nvme_status_ext->regctl_eds[i].hostid, 0, 16);
>> + }
>> +
>> + rc = nvme_c2h(n, (uint8_t *)nvme_status_ext, len, req);
>> + g_free(nvme_status_ext);
>> + return rc;
>> +}

--0000000000006ef99a0620b87482
Content-Type: text/html; charset="UTF-8"

<p>Hi,
<br>
<br>Thanks for your advice.
<br>Previously, g_malloc0 was used, but a segmentation
<br>fault occurred during testing. Later, debugging
<br>revealed that a field in struct NvmeReservationStatusExt,
<br>struct NvmeRegisteredCtrlExt regctl_eds[], was a
<br>variable-length array. Therefore, g_malloc was used
<br>to apply after the array length was determined.
<br>Therefore, g_malloc0 was not used here.
<br>
<br>On 2024/8/28 14:10, Klaus Jensen wrote:
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
<br>&gt;&gt; +static int nvme_read_reservation_cb(NvmeReadReservation *reservation)
<br>&gt;&gt; +{
<br>&gt;&gt; +    int rc;
<br>&gt;&gt; +    NvmeReservationStatus *nvme_status;
<br>&gt;&gt; +    NvmeRequest *req = reservation-&gt;req;
<br>&gt;&gt; +    NvmeCtrl *n = req-&gt;sq-&gt;ctrl;
<br>&gt;&gt; +    NvmeResvKeys *keys_info = reservation-&gt;keys_info;
<br>&gt;&gt; +    int len = sizeof(NvmeReservationStatusHeader) +
<br>&gt;&gt; +              sizeof(NvmeRegisteredCtrl) * keys_info-&gt;num_keys;
<br>&gt;&gt; +
<br>&gt;&gt; +    nvme_status = g_malloc(len);
<br>&gt;&gt; +    nvme_status-&gt;header.gen = reservation-&gt;generation;
<br>&gt;&gt; +    nvme_status-&gt;header.rtype = block_pr_type_to_nvme(reservation-&gt;type);
<br>&gt;&gt; +    nvme_status-&gt;header.regctl = keys_info-&gt;num_keys;
<br>&gt;&gt; +    for (int i = 0; i &lt; keys_info-&gt;num_keys; i++) {
<br>&gt;&gt; +        nvme_status-&gt;regctl_ds[i].cntlid = nvme_ctrl(req)-&gt;cntlid;
<br>&gt;&gt; +        nvme_status-&gt;regctl_ds[i].rkey = keys_info-&gt;keys[i];
<br>&gt;&gt; +        nvme_status-&gt;regctl_ds[i].rcsts = keys_info-&gt;keys[i] ==
<br>&gt;&gt; +                                          reservation-&gt;key ? 1 : 0;
<br>&gt;&gt; +        /* hostid is not supported currently */
<br>&gt;&gt; +        memset(&amp;nvme_status-&gt;regctl_ds[i].hostid, 0, 8);
<br>&gt;&gt; +    }
<br>&gt;&gt; +
<br>&gt;&gt; +    rc = nvme_c2h(n, (uint8_t *)nvme_status, len, req);
<br>&gt;&gt; +    g_free(nvme_status);
<br>&gt;&gt; +    return rc;
<br>&gt;&gt; +}
<br>&gt;&gt; +
<br>&gt;&gt; +static int nvme_read_reservation_ext_cb(NvmeReadReservation *reservation)
<br>&gt;&gt; +{
<br>&gt;&gt; +    int rc;
<br>&gt;&gt; +    NvmeReservationStatusExt *nvme_status_ext;
<br>&gt;&gt; +    NvmeRequest *req = reservation-&gt;req;
<br>&gt;&gt; +    NvmeCtrl *n = req-&gt;sq-&gt;ctrl;
<br>&gt;&gt; +    NvmeResvKeys *keys_info = reservation-&gt;keys_info;
<br>&gt;&gt; +    int len = sizeof(NvmeReservationStatusHeader) +
<br>&gt;&gt; +              sizeof(uint8_t) * 40 +
<br>&gt;&gt; +              sizeof(NvmeRegisteredCtrlExt) * keys_info-&gt;num_keys;
<br>&gt;&gt; +
<br>&gt;&gt; +    nvme_status_ext = g_malloc(len);
<br>&gt; 
<br>&gt; This leaks heap memory due to uninitialized reserved fields in
<br>&gt; NvmeReservationStatusExt. Prefer g_malloc0.
<br>&gt; 
<br>&gt; The one above in nvme_read_reservation_cb looks safe, but prefer
<br>&gt; g_malloc0 there anyway.
<br>&gt; 
<br>&gt;&gt; +    nvme_status_ext-&gt;header.gen = cpu_to_be32(reservation-&gt;generation);
<br>&gt;&gt; +    nvme_status_ext-&gt;header.rtype = block_pr_type_to_nvme(reservation-&gt;type);
<br>&gt;&gt; +    nvme_status_ext-&gt;header.regctl = cpu_to_be16(keys_info-&gt;num_keys);
<br>&gt;&gt; +
<br>&gt;&gt; +    for (int i = 0; i &lt; keys_info-&gt;num_keys; i++) {
<br>&gt;&gt; +        uint16_t ctnlid = nvme_ctrl(req)-&gt;cntlid;
<br>&gt;&gt; +        nvme_status_ext-&gt;regctl_eds[i].cntlid = cpu_to_be16(ctnlid);
<br>&gt;&gt; +        nvme_status_ext-&gt;regctl_eds[i].rkey = cpu_to_be64(keys_info-&gt;keys[i]);
<br>&gt;&gt; +        nvme_status_ext-&gt;regctl_eds[i].rcsts = keys_info-&gt;keys[i] ==
<br>&gt;&gt; +                                               reservation-&gt;key ? 1 : 0;
<br>&gt;&gt; +        /* hostid is not supported currently */
<br>&gt;&gt; +        memset(&amp;nvme_status_ext-&gt;regctl_eds[i].hostid, 0, 16);
<br>&gt;&gt; +    }
<br>&gt;&gt; +
<br>&gt;&gt; +    rc = nvme_c2h(n, (uint8_t *)nvme_status_ext, len, req);
<br>&gt;&gt; +    g_free(nvme_status_ext);
<br>&gt;&gt; +    return rc;
<br>&gt;&gt; +}</p>

--0000000000006ef99a0620b87482--

