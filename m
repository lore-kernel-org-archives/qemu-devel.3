Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 720BBEFCD72
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 09:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzX9b-0003dm-17; Mon, 09 Mar 2026 05:43:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vzX9X-0003cU-Kg
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 05:43:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vzX9U-0007wv-C5
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 05:43:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773049431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BoGz65fPCwazhQrV4HZn7xRTG51MR4vI7CiRxISHug8=;
 b=fREbC/v5L6ZaxYJGzuJ7Cz/I5hu6VWJbAGumwa3bqntGGxblQkUD7D/c6/h6SQyecfgIzG
 8W1lFX9iK9A0jdB+hJxdxR48YjZ+GgILlXB5IPSLnPhQjaTT3nLKA+87/47oG+98bweYnY
 erYnfkNrNxLbR8Ma5a/Lt0ebZdmzQRU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-Mcm1mMsEMlC8iKyQs9Dngw-1; Mon, 09 Mar 2026 05:43:49 -0400
X-MC-Unique: Mcm1mMsEMlC8iKyQs9Dngw-1
X-Mimecast-MFC-AGG-ID: Mcm1mMsEMlC8iKyQs9Dngw_1773049428
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4853efceaddso2952415e9.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 02:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773049428; x=1773654228; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=BoGz65fPCwazhQrV4HZn7xRTG51MR4vI7CiRxISHug8=;
 b=Vm4wRmh4ONRlmE/Xw9pc4mGvasMRLuLAjDbU81EyMkLWOe90NxuxxJl2uMHoh+6skN
 PMacYNvHwH3jcj+U7tjvpQfEC501WvIQA3o044ZFWeTWmRE7dQ+dMpLcjjk/Z6jQKci2
 oauUFH5VwADKdVVR1MI6D/GFQe1bQn4zsb7xEPaSXmtUF0kbs+t1l6MqKsWGgBwI3tQp
 N97SpTYy9IFEMdEgBOA6TEVEgJZA6fTNzADvEOmnAUl7xwQSA0R0+fHSyloY7ADHzDqe
 96A67hACkxnMNkdYvT1lbAV2TPL6/VkWOR7uYmvB8JsfNvL+k5/+RifOTUAyD3oq+beY
 hlSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773049428; x=1773654228;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BoGz65fPCwazhQrV4HZn7xRTG51MR4vI7CiRxISHug8=;
 b=RuUsnwW3CpcXpyVPJ7bqn2kKqwOb3kqdgbnQ+WNP0HmLHUGU01EdTjTNTTbfMB5Hhb
 tIOqbZlbPS9SWqAhvGrMdSWD0I5rMCOmfR8JI89Gdh1yPxxGad8Ia8mbgx/u3fvk8pNh
 UHJjN5gwW9IkcmMU2cthgFfkzKUyRLpXYqCp8gZq+PyeUH7oOwi34DeNOWFYZBLn0R2g
 miarc+3ZCj9ub2xKdOdVBOCSImjdRNTcOIz8K0jvnyAU+bmZNKn4jqrv1HYUBNbPpwDB
 U0z/LdgV+1GJNuqpQS+D0xxBFy5LkG37cjKj947mfh8yK/6T5/JrPQ0rejaiKbZll3CM
 nH0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkeV2LmLrT2gCRRiW6M0oaRVdFRTtbu6Rho9AQmWdewksp5GVsx8wr1OBZk88aT14ltXJXI0BdOpiu@nongnu.org
X-Gm-Message-State: AOJu0YzvgEzd5rQPl1oxB/jnW5pUT5FowLmPMcZXJ7h5gfN0qFdyr8Kx
 mEdVLneF+0XHa4zwgQa973aMlgqzm/nfG+y1NoaTjXLfqVH6xfvUbQO6RPbW9Dbw0Bo+lnvGkMA
 m6aZ9cL1wl++QX88WwdhUv5fu2vj6Ex7/JbT7id68VemsgBd2b3+hUrLZ
X-Gm-Gg: ATEYQzxdHeVwS3kXNkYb0j6dZ+ednyObZ2JepB6kyloo6877IvtyO2CsUjH7nKD3WDJ
 3MeGHJ+lEGXBhvtWW+I8869NfqKQAD8INxxWELtdFGPzfuZOyQ2xO5oj5RXWhqcKDxKPRSgN6v+
 ChhTECQHxhbhdcRXYpR6Nu3QgZkToRkQCbL0f+USNTsNp+GgMRlhZtDgbWSQEKiHfgPTnmLjAv8
 xNrHcFWPyVdfDIEhDx0QxQktB1iLck04MlBQqjgmPGZhdjdUb0Rvqac5obDvmF6DHl5Kj0mHG8F
 mD4HUD0oSC+T/Nlr+YcfbuVP7hthpM6X0OEbtuiz9CoHAfSWzRB63vuspXvdTW8QPhRBHFcjDaQ
 IM92K51kvQ8mJMvQkVu9rBTQzKQ2GUvl+WQ5yy0Fc9Ok8UZGIVF8JxrrNishr
X-Received: by 2002:a05:600c:4e8a:b0:485:3f41:e113 with SMTP id
 5b1f17b1804b1-4853f41e355mr15141935e9.1.1773049427941; 
 Mon, 09 Mar 2026 02:43:47 -0700 (PDT)
X-Received: by 2002:a05:600c:4e8a:b0:485:3f41:e113 with SMTP id
 5b1f17b1804b1-4853f41e355mr15141615e9.1.1773049427459; 
 Mon, 09 Mar 2026 02:43:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48527686bcesm404264375e9.7.2026.03.09.02.43.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 02:43:47 -0700 (PDT)
Message-ID: <655d295e-06e6-4312-9e7c-2ca5cb6bc838@redhat.com>
Date: Mon, 9 Mar 2026 10:43:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 14/38] hw/i3c/dw-i3c: Add data TX and RX
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>, Joe Komlodi <komlodi@google.com>,
 Stephen Longfield <slongfield@google.com>,
 Patrick Venture <venture@google.com>,
 Jithu Joseph <jithu.joseph@oss.qualcomm.com>
References: <20260305175711.1119025-1-clg@redhat.com>
 <20260305175711.1119025-15-clg@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260305175711.1119025-15-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hello,

On 3/5/26 18:56, Cédric Le Goater wrote:
> From: Jamin Lin <jamin_lin@aspeedtech.com>
> 
> This adds data and CCC transmission, reception, and the associated
> queues required for data transmission and reception to happen.
> 
> The I3C controller transmits data by the user writing into a command
> queue. When the queue has a command and an argument in it, the
> controller starts executing the command.
> 
> The controller can execute 1 of 3 ways:
> 1. A larger data transfer that involves using the TX and RX queues. This
>     is the most common way the controller does transactions.
> 
> 2. A small data transfer that involves sending a couple bytes passed
>     into the command queue argument.
> 
> 3. An address assignment command. This is how the controller does
>     ENTDAA. When ENTDAA succeeds in assigning an address to a target, it
>     updates the controller's char table with the target's PID, BCR, and
>     DCR.
> 
> The controller determines what addresses to send by looking at the index
> in the device address table specified by the argument in the command
> queue. ENTDAA also uses these addresses to assign to targets on the bus.
> 
> When the controller is done executing a command, it puts a response in
> the response queue indicating how command execution went.
> 
> In order for the user to send and receive data to/from the controller,
> the user reads/writes to a bidirectional TX/RX port.
> 
> Signed-off-by: Joe Komlodi <komlodi@google.com>
> Reviewed-by: Stephen Longfield <slongfield@google.com>
> Reviewed-by: Patrick Venture <venture@google.com>
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Tested-by: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
> Link: https://lore.kernel.org/qemu-devel/20260225021158.1586584-14-jamin_lin@aspeedtech.com
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   include/hw/i3c/aspeed_i3c.h |   1 +
>   include/hw/i3c/dw-i3c.h     | 143 +++++-
>   hw/i3c/dw-i3c.c             | 882 +++++++++++++++++++++++++++++++++++-
>   hw/i3c/trace-events         |  10 +
>   4 files changed, 1030 insertions(+), 6 deletions(-)



Coverity reports an "Uninitialized variables" issue :

   _____________________________________________________________________________________________
   *** CID 1645555:         Uninitialized variables  (UNINIT)
   /builds/qemu-project/qemu/hw/i3c/dw-i3c.c: 1229             in dw_i3c_short_transfer()
   1223         }
   1224         if (arg.byte_strb & 0x04) {
   1225             data[len] = arg.byte2;
   1226             len++;
   1227         }
   1228
   >>>     CID 1645555:         Uninitialized variables  (UNINIT)
   >>>     Using uninitialized value "*data" when calling "dw_i3c_send".
   1229         if (dw_i3c_send(s, data, len, &bytes_sent, is_i2c)) {
   1230             err = DW_I3C_RESP_QUEUE_ERR_I2C_NACK;
   1231         } else {
   1232             /* Only go to an idle state on a successful transfer. */
   1233             ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,
   1234                              DW_I3C_TRANSFER_STATE_IDLE);


Should we call dw_i3c_send() when len == 0 ?

Thanks,

C.

> +static void dw_i3c_short_transfer(DWI3C *s, DWI3CTransferCmd cmd,
> +                                  DWI3CShortArg arg)
> +{
> +    uint8_t err = DW_I3C_RESP_QUEUE_ERR_NONE;
> +    uint8_t addr = dw_i3c_target_addr(s, cmd.dev_index);
> +    bool is_i2c = dw_i3c_target_is_i2c(s, cmd.dev_index);
> +    uint8_t data[4]; /* Max we can send on a short transfer is 4 bytes. */
> +    uint8_t len = 0;
> +    uint32_t bytes_sent; /* Ignored on short transfers. */
> +
> +    /* Can't do reads on a short transfer. */
> +    if (cmd.rnw) {
> +        g_autofree char *path = object_get_canonical_path(OBJECT(s));
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Cannot do a read on a short "
> +                      "transfer\n", path);
> +        return;
> +    }
> +
> +    if (dw_i3c_send_start(s, addr, /*is_recv=*/false, is_i2c)) {
> +        err = DW_I3C_RESP_QUEUE_ERR_I2C_NACK;
> +        goto transfer_done;
> +    }
> +
> +    /* Are we sending a command? */
> +    if (cmd.cp) {
> +        data[len] = cmd.cmd;
> +        len++;
> +        /*
> +         * byte0 is the defining byte for a command, and is only sent if a
> +         * command is present and if the command has a defining byte present.
> +         * (byte_strb & 0x01) is always treated as set by the controller, and is
> +         * ignored.
> +         */
> +        if (cmd.dbp) {
> +            data[len] += arg.byte0;
> +            len++;
> +        }
> +    }
> +
> +    /* Send the bytes passed in the argument. */
> +    if (arg.byte_strb & 0x02) {
> +        data[len] = arg.byte1;
> +        len++;
> +    }
> +    if (arg.byte_strb & 0x04) {
> +        data[len] = arg.byte2;
> +        len++;
> +    }
> +
> +    if (dw_i3c_send(s, data, len, &bytes_sent, is_i2c)) {
> +        err = DW_I3C_RESP_QUEUE_ERR_I2C_NACK;
> +    } else {
> +        /* Only go to an idle state on a successful transfer. */
> +        ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,
> +                         DW_I3C_TRANSFER_STATE_IDLE);
> +    }
> +
> +transfer_done:
> +    if (cmd.toc) {
> +        dw_i3c_end_transfer(s, is_i2c);
> +    }
> +    if (cmd.roc) {
> +        /*
> +         * ccc_type is always 0 in controller mode, data_len is 0 in short
> +         * transfers.
> +         */
> +        dw_i3c_resp_queue_push(s, err, cmd.tid, /*ccc_type=*/0,
> +                                          /*data_len=*/0);
> +    }
> +}
> +


