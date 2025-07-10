Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 877C6C83F1D
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 13:27:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZrIv-0001Cf-Ry; Thu, 10 Jul 2025 09:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZrI7-0000Ht-ND
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 09:26:23 -0400
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZrI5-0007gL-Kr
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 09:26:23 -0400
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e740a09eae0so926061276.1
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 06:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752153979; x=1752758779; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PJRk60/i+29Mq+QF6TUKPvYbMJka1Yla5MR4tq4Ygd4=;
 b=FvEjI4j93b4dc7Dqpv6KBv3MLh1+MEyFFZck8FOolDylsh+3OO9pSWBfnJXRy4kPHY
 vzEVR1vcqgX8XVpjigvmiOO+Pt4OnXoAIelQx4oyH3lua7tEFyDA7kfPjOssJ6q/K9of
 D/y+x9FhWl6SAk0DXwQ8yrzwsNjzla9viGskiZRkcf0iat2LSxp4XqPko3h6K4KHYI7S
 2zFEgc39Oxkd5SKG0p8Gzmpv7aPPwCUvz9dvir3amv926eK4HHRGEhQi+fLghIREfWF+
 aqf5J2rYqW6Fyj2wIXaBqT2XwtSjA4Oo2EqYK5lTJDXDoU20+/waDX1aDbjD13ThteSW
 9pig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752153979; x=1752758779;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PJRk60/i+29Mq+QF6TUKPvYbMJka1Yla5MR4tq4Ygd4=;
 b=i3seK7gAK2JWClvXybhCaupa3vSfENd0BwLm/AWhi/7ksUjDFMtavCMDVOhu17MzJ8
 Lcc+TsVTibUCYtRg51i2ZuIJDGIuS6HE0dCNZ5D8AOyjhLcqEX0ktMe06RXvf+Zmf4sn
 N5FvFAQjpo1idjV1tpAkCkq9xuO75v/woL3mXo/ePBS3glY485JwLPHqFuAO4SKXxKWZ
 HCkmzDWOB3zPh00863knt109K331htQtgsVawrBvxcRTEYqHZ9lb8KBdUwWYlAsNze0o
 q2+lLOc9DAYMsbLL+VNHRU8Hg9GKl04oQhLNytmAi09yPXxF3WfwQMlmEqkL8LZoSERl
 xRUQ==
X-Gm-Message-State: AOJu0YxCEjIf8xwOsbYTpkzzY9kIinTEtfSkm5T2JsBBqyVWmD1LlVUg
 YEfT2x4xwDzJO91ChET5z6V9IFiMIx4Z6aGi4h+GvUKzsMbHMfoSBv/mMMvBztp1WRLVJ90AGDF
 sFIP7G+XX8BCS6l14cZCUzKzcWzMcTGmeEg6Su1R0JkeiokWTMe2S
X-Gm-Gg: ASbGnctXMsa0pujHjT8GFyO/+xn3rZJVa3EOI2B/mW4ass6eeaq3d9+rrfShkNPKJLs
 rV8LwuEgAMDZNSVxPMCpAB/ZHix1/ut5859nP+AkO+jFnFkP6z1HIDS0QZDIqpS75BaPO9807nX
 tgE3HgghmSt5BWHD1JjUpYJ5DrSszMLWQyPNWpB07rqLaw
X-Google-Smtp-Source: AGHT+IFObqBJ3Mo4ZxlfNQpYRan7BjFFOgg0zCHlL+IoN3fYVdts5FLMvlm4Y/Qk+TqgjkX59+T0XChwPMymKMzw7ek=
X-Received: by 2002:a05:690c:6b0e:b0:70f:6ec6:62b2 with SMTP id
 00721157ae682-717b166f94amr95131907b3.8.1752153979300; Thu, 10 Jul 2025
 06:26:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1747223385.git.mst@redhat.com>
 <77a8e9fe0ecb71b260d17f43221df5b18769b359.1747223385.git.mst@redhat.com>
In-Reply-To: <77a8e9fe0ecb71b260d17f43221df5b18769b359.1747223385.git.mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Jul 2025 14:26:07 +0100
X-Gm-Features: Ac12FXzfwXzP0TfQUZDzIc0xbp1yNAUnkEQwDcK1ud49L6cFMthtKwv34Hse5Nk
Message-ID: <CAFEAcA-p5wZkNxK7wNVq_3PAzEE-muOd1Def-0O-FSpck4DrBQ@mail.gmail.com>
Subject: Re: [PULL 03/27] hw/cxl/cxl-mailbox-utils: Add support for Media
 operations discovery commands cxl r3.2 (8.2.10.9.5.3)
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Vinayak Holikatti <vinayak.kh@samsung.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b31;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 14 May 2025 at 12:50, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> From: Vinayak Holikatti <vinayak.kh@samsung.com>
>
> CXL spec 3.2 section 8.2.10.9.5.3 describes media operations commands.
> CXL devices supports media operations discovery command.
>
> Signed-off-by: Vinayak Holikatti <vinayak.kh@samsung.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Message-Id: <20250305092501.191929-4-Jonathan.Cameron@huawei.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c | 125 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 125 insertions(+)



> +static CXLRetCode media_operations_discovery(uint8_t *payload_in,
> +                                             size_t len_in,
> +                                             uint8_t *payload_out,
> +                                             size_t *len_out)
> +{
> +    struct {
> +        uint8_t media_operation_class;
> +        uint8_t media_operation_subclass;
> +        uint8_t rsvd[2];
> +        uint32_t dpa_range_count;
> +        struct {
> +            uint16_t start_index;
> +            uint16_t num_ops;
> +        } discovery_osa;
> +    } QEMU_PACKED *media_op_in_disc_pl = (void *)payload_in;
> +    struct media_op_discovery_out_pl *media_out_pl =
> +        (struct media_op_discovery_out_pl *)payload_out;
> +    int num_ops, start_index, i;
> +    int count = 0;
> +
> +    if (len_in < sizeof(*media_op_in_disc_pl)) {
> +        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> +    }
> +
> +    num_ops = media_op_in_disc_pl->discovery_osa.num_ops;
> +    start_index = media_op_in_disc_pl->discovery_osa.start_index;
> +
> +    /*
> +     * As per spec CXL r3.2 8.2.10.9.5.3 dpa_range_count should be zero and
> +     * start index should not exceed the total number of entries for discovery
> +     * sub class command.
> +     */
> +    if (media_op_in_disc_pl->dpa_range_count ||
> +        start_index > ARRAY_SIZE(media_op_matrix)) {

Coverity thinks this bounds check is wrong (CID 1610091):
we allow start_index equal to the ARRAY_SIZE(media_op_matrix),
which means that in the loop below we will index off the
end of the array.

Don't we also need to be checking (start_index + num_ops)
against the array size bounds, not just start_index ?

> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    media_out_pl->dpa_range_granularity = CXL_CACHE_LINE_SIZE;
> +    media_out_pl->total_supported_operations =
> +                                     ARRAY_SIZE(media_op_matrix);
> +    if (num_ops > 0) {
> +        for (i = start_index; i < start_index + num_ops; i++) {
> +            media_out_pl->entry[count].media_op_class =
> +                    media_op_matrix[i].media_op_class;
> +            media_out_pl->entry[count].media_op_subclass =
> +                        media_op_matrix[i].media_op_subclass;
> +            count++;
> +            if (count == num_ops) {
> +                break;
> +            }
> +        }
> +    }
> +
> +    media_out_pl->num_of_supported_operations = count;
> +    *len_out = sizeof(*media_out_pl) + count * sizeof(*media_out_pl->entry);
> +    return CXL_MBOX_SUCCESS;
> +}

The functions in this patch also look like they aren't correctly
handling the "guest and host endianness differ" case.

thanks
-- PMM

