Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C87E60A2631
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 11:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=HAVJ4nXt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUMWe-0001ZF-0Z; Fri, 20 Nov 2026 06:11:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xUMWb-0001Yu-Nt
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 06:11:25 -0500
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xUMWZ-00065y-Qo
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 06:11:25 -0500
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-67be4f2f4d4so945632d50.2
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 03:11:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795173080; cv=none;
 d=google.com; s=arc-20260327;
 b=f3KhYIcQIky1/ClOicgzB56UlZlZyVAAw6YYB/vT5nsWtdQ77sTVO7tlT19RYnm/Lp
 YXHau6F2s2H2ZVcg24u1QW8Z0qVExSJcYA6UZdKRrrxy/lvNh0bqJU7k3WK2ICso2/zo
 04xHo6qdR9T+K1r2HHKpqCLd92e2FH0XnY3Ufrvp0xwfB6wdvX3Eayo8zx+khkri83Ym
 PwnlUs0iHP20AgnAPck217a8UBP0AZXZGR0QLfzPaS03rXqylFmnN2jsbsvG5GgocJcC
 1ZnsVzE5M1frB3qrx8SVnHqzpEr6r05VmNhNpMaxyAtEzF+2VUCv16W5VleFn4NJ2uBK
 UgDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=JlbbXh3veM9/VvkJ/1Iw5pgFvYguw2fNEos3kNnkPLE=;
 fh=jis90ebI1LXbWlN2f/uPaYiR3/160S3+nBo5cgb+Jhw=;
 b=cG1tzOlt3uSkUWl3iF0W8yf6L83el+TSR7Af9pR9eztMZVO2goQYhqv4uElSJnrJ4i
 fkoAXATkWI7GDemW58SQRktpsjCqL+Jesl9aQ2PvUQvQsC4Gm0dWCY8gVky+tee9e1AN
 LXmjruObQPefRGhMLTLLngJ9ZAcjyEplocTQ1ZNtwGVpeStlup7xrjmSVppKhuNXnMYZ
 6jTEJT6vbA7qlOvxoO+39EQcBUuZrPTc0gEiRUT0yNSDbRhC7pLoZhYhgfkExWYaZQu3
 vzNLRXZh4cAG17j36toSDfkcGt0RfDruBdLsLy1ie6xZn7X859IEu9WPiEdgx2qjaXfn
 8QxA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795173080; x=1795777880; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JlbbXh3veM9/VvkJ/1Iw5pgFvYguw2fNEos3kNnkPLE=;
 b=HAVJ4nXtEymNk8BEM4q3ovLAX9vu9fbYGmAGfkqJj4sBbaAYYdh4nwC2K34G1EchNJ
 7Ba5yAfmRHaTvEJe1gI9dlwo18A+j0ruC1HFqB41idw5Ic5D7fRAL7sxnxxgzYAjui7G
 G0lachKKZFs8T7lhWv3jObxIHz20i8262S6gvUYZuAd+SLZMVa3TkyAyA6zprAD+Ba+E
 jJ6ROMETj5lRhgIK8qHkY++MsDFCMw+BW4qf8kiQ24GJO0ULYf6uaC5Czl5Hc8dIixnj
 7uDd3GtMzWQyzUM0X3JAACpJM2ZdDzejWf9uaUfhct0gyPjdfnl8sWlMcUNMI0zZCgud
 RMrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795173080; x=1795777880;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JlbbXh3veM9/VvkJ/1Iw5pgFvYguw2fNEos3kNnkPLE=;
 b=iczSA/wLKfeDOaGuW9DKDS5UrM6GDFHJiEVplG7iqLStSNZt5f64h6Jso+OxXOXRxP
 ygzPiBapZR+Z5JAeTFnl7mECA9V5Uv9w6RsArfB8q/AZI41ErOPePa3prboTbBX/OXHw
 2saXB/NQQxfcJYsPzaGhbG18QVC2zXkKA2yKIDiIdKz3y8DgQ1LdqhMIGFcsxCgY+R8P
 RMbaYhGEo+NWhaVhOrcq8+xpeTw6Y1ZCsR5ZZ3ffrOyyTO5oH0dpiRAV7W7Ryk4F3oWy
 fSVIP+QuhEkfCTAXT1uKbmvaWwHf4SgmoyOtk0H0/We4ARx6MqS+Uu/LsMxVkQSBtJkk
 vOZg==
X-Gm-Message-State: APuU4Z+5KL1aTUQIukOQgvigNFpw4mjzEhUCFMf6G0W6rDH0ZwVPLs8R
 n9wt/HX4ElMFJCZHANZHFILGo7pQlIbKfXyaOnsCsiEqBkXh/tQcm6RX0R8/JSAefEo+FxKosaR
 gQV9/PtGPi7quJq/AnKwdTI9/vQ8B2GfD0NExCw8yfw==
X-Gm-Gg: AZFdTZdj6ULfBSHT7x32sB5ZNPMYIzHtpfS3MCJ39a/voy6fpBhdzzJ6ZljQ+ovf910
 PVKDmeoic1QNS94ylwFLFXj636d/SXd5SMNIADuf0RV+E6Jjy4J+kt9VUudTRYzWEcNEVLxKLvX
 bA3f+UN+Fv4fesQEL+wsTF7xuGGEzdHgbhfOfOfUzuUvhbkJSCAQL69S7QdPMaCGTB7LMLctC4g
 TctNyCZOTphS0NpVaGDqMomqvvZYTvA2ab6ptl5M7ak/uRCmRuo4jX+RK4Fdx+r2GOifi2uWic8
 ZOckxQbPdo7PGUYyoxKA4DUKplGO+iFdYUxp3Wt1yCs0kb3S/iKa4UGZRnmxCCHeV3UWIMeQCjE
 X4c/JOQr0wZiGthBx2RkFm7xbwyv85wPYcSMQD8wI68OttVtjhxdmpsHrhG39yQ1cbSEyqLMAiZ
 EFDBUZBhG+BpXmkXeR2HVD
X-Received: by 2002:a05:690e:408f:b0:67d:9fef:d60c with SMTP id
 956f58d0204a3-67df9015306mr666883d50.17.1795173080241; Fri, 20 Nov 2026
 03:11:20 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAFEAcA-iAdTGc0M4ZV5LYXscVVj2oEr7FN+Ac=oBo2_oxuygzg@mail.gmail.com>
 <av8k8oiG8lRh5bVI@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <CAFEAcA_8EAke9-dk-2HfkQ5BJyuODtcSK+DUcmYKRSKgEf=Wnw@mail.gmail.com>
 <av9D4pVMM989xNcE@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <CAFEAcA8UWw+CpaS8wyy0A_MSeXhJ3NzJGcLm-iHkzmw5t9Cd_w@mail.gmail.com>
 <av9be5IWLpQJu-F_@zhexu-thinkpadt14gen5.rmtcaon.csb>
In-Reply-To: <av9be5IWLpQJu-F_@zhexu-thinkpadt14gen5.rmtcaon.csb>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Nov 2026 11:11:07 +0000
X-Gm-Features: AclHuK-aqZifpGg_fdzCYPkzxjQPw1L5MRDMO__qUJQGxk7sxhclZ7jtaY-H_Ns
Message-ID: <CAFEAcA-fmyi6iWBbXmUUWkf=-9duEySHyPE_ELz8FLgcrhcGAQ@mail.gmail.com>
Subject: Re: VMSTATE_VALIDATE failures on outbound migration
To: Peter Xu <peterx@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 19 Nov 2026 at 20:26, Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Nov 19, 2026 at 06:53:19PM +0000, Peter Maydell wrote:
> > I don't think you can deal with the pcie_aer usage this way though,
> > can you ?
>
> Attached a patch for that, please have a look.
>
> IMHO it's a matter of if we think VMSTATE_VALIDATE() useful.  At least for
> the current form, I don't like it, especially hijacking the field_exists().
> I hope post_load_errp() is enough.
>
> Thanks,
>
> ===8<===
> From d92c2548ea084091d3baf51682b150dd4e0f2316 Mon Sep 17 00:00:00 2001
> From: Peter Xu <peterx@redhat.com>
> Date: Thu, 19 Nov 2026 14:53:47 -0500
> Subject: [PATCH] pcie/aer: Remove the usage of VMSTATE_VALIDATE()
>
> Paving way removing it.  We can replace it with a post_load_errp() instead.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  hw/pci/pcie_aer.c | 40 +++++++++++++++++++++++++++++++++++-----
>  1 file changed, 35 insertions(+), 5 deletions(-)
>
> diff --git a/hw/pci/pcie_aer.c b/hw/pci/pcie_aer.c
> index 43b14c1f22..87248556d4 100644
> --- a/hw/pci/pcie_aer.c
> +++ b/hw/pci/pcie_aer.c
> @@ -807,21 +807,51 @@ static const VMStateDescription vmstate_pcie_aer_err = {
>      }
>  };
>
> -static bool pcie_aer_state_log_num_valid(void *opaque, int version_id)
> -{
> -    PCIEAERLog *s = opaque;
> +typedef struct {
> +    uint16_t v;
> +} tmp_u16;
>
> +static bool pcie_aer_state_log_num_valid(PCIEAERLog *s)
> +{
>      return s->log_num <= s->log_max;
>  }
>
> +static bool pcie_aer_state_log_num_post_load(void *opaque, int version,
> +                                             Error **errp)
> +{
> +    PCIEAERLog *s = container_of(opaque, PCIEAERLog, log_num);
> +
> +    if (!pcie_aer_state_log_num_valid(s)) {
> +        error_setg(errp, "PCIe AER log num too big: log_num > log_max");
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
> +static const VMStateDescription vmstate_pcie_aer_log_num = {
> +    .name = "PCIE_AER_ERROR_LOG/NUM",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .post_load_errp = pcie_aer_state_log_num_post_load,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT16(v, tmp_u16),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  const VMStateDescription vmstate_pcie_aer_log = {
>      .name = "PCIE_AER_ERROR_LOG",
>      .version_id = 1,
>      .minimum_version_id = 1,
>      .fields = (const VMStateField[]) {
> -        VMSTATE_UINT16(log_num, PCIEAERLog),
> +        /*
> +         * Only to use STRUCT for a post_load_errp().  New code should try
> +         * to use something look better, e.g. subsections in order.
> +         */
> +        VMSTATE_STRUCT(log_num, PCIEAERLog, 1,
> +                       vmstate_pcie_aer_log_num, uint16_t),
>          VMSTATE_UINT16_EQUAL(log_max, PCIEAERLog),
> -        VMSTATE_VALIDATE("log_num <= log_max", pcie_aer_state_log_num_valid),
>          VMSTATE_STRUCT_VARRAY_POINTER_UINT16(log, PCIEAERLog, log_num,
>                                vmstate_pcie_aer_err, PCIEAERErr),
>          VMSTATE_END_OF_LIST()

This seems to me to be worse -- instead of a macro that clearly
and fairly succinctly says "we're validating something here",
we now are using VMSTATE_STRUCT not because there's actually a
struct in the migration data, but for its side effects in having
a post_load function, and we have to create a dummy struct type
as well. If we want to be able to have the validate check
set an Error, I think I'd rather that we changed the API
of the validate function to take an Error**.

I don't think "validate, and it happens that I need a custom
function to do that" should be this much more complicated than
"validate using one of the standard checks like
VMSTATE_UINT16_EQUAL".

-- PMM

