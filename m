Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3B7606A326
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 09:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=a8IrCIwJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOtjR-000687-Ba; Thu, 05 Nov 2026 04:26:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOtjO-00067q-La
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:26:02 -0500
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOtjM-0006pB-Jj
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:26:02 -0500
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-8b300713befso15278827b3.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 01:25:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793870758; cv=none;
 d=google.com; s=arc-20260327;
 b=q90I61j81Ebnc5faX5Z67w2hIRQPB7rcIrtfI/JzM/dALYtu8Mmg7uBJRuThObDBpb
 UQDxcwZiIKBbS1WScNePOkQvIVYsYGWu7UDhEYhSdiXY/kRYqzihXAAuQdPbhqgz52I1
 aEMsOrG2jU5XsXMyKowHj8H+TzfR8h48f3Zf/gVTe3lHzb51vJOrKU0B0MssA3FKVvNe
 KE41i7I1Zs/aUOI6W0AYmSMVttUIp0QBTtRqXulM/PFs2N8FjkuldZ+qD46HKRi1/CVu
 a1js9C6bFa+OD/IPg3UzgqFOqqL2bVq6+p0TDf8Sun/ZJSd8A5ovkL3CY27qWNoaaz5V
 XR1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=JYl95H/CdIMAcQ5+GL1ullL/HHcWKMOpzAGoH8saEkE=;
 fh=GzxBTHQloWqJfnrmUBXdrSWlBYRF+fQvhYVjQyZiL/w=;
 b=A0S4RfrQEW6zcJiQ+Mqstl6tNAEJfcI7Sw2/YhEBKFNcyNRcuCTnHaP1/70eOym8uE
 I7ZVjK3rIjN+HE0OvELQ4sOV8/lTioGwu61S7Au1/g4G97/dmfmqV6UqSOC7F2XGcjFL
 q9XzgLlEijuiozMQnl2KMz14vyg36a8252TiqifFVQo6a02UfKlWL/P/9++liyEkE1yk
 MVvKHoCIEgy/OFdxrtp+0iHjFs2o/EDfkOyL75HjCv6MLmmZWAlKZEciTC4iWn1kIuhN
 J3MKHxf/ddijyoOWl27fL5LyIspDjJGRcy/5QbREImuFkkFjUu4eCpzVXTWLKfTUdPf9
 w/QQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793870758; x=1794475558; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JYl95H/CdIMAcQ5+GL1ullL/HHcWKMOpzAGoH8saEkE=;
 b=a8IrCIwJ+EftmIBuyQs5pE+6v0f6L0+9dFXG4yKS8z32JlA45rrhT/kAga9+IOjfn7
 3LkVrGy6cAk9TKkZ9QKvqRycWWV83ua5qfpWfUlmbrNa0Z35V8+6/9wM9Bx3AXNlKmoN
 4wm89Dxzh7SR1nij0nxsjJcgvsf5Ne/X/XTe/n9z7NinxItw2Zfy+ZEvDQjGMarA1Bkt
 Su6qsFedJ0uC/0nj1apSXLetHGfHbyArzs56K9vewRzLw4oMtpWNvF5vGoZ8ZRbLzzIs
 A7O2Yw6MjKuGVxqqlI/YeWk/5SYONFupPez7uVPnBKIQWP4XG1dOs07CauFWJtqFhM1Z
 QJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793870758; x=1794475558;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JYl95H/CdIMAcQ5+GL1ullL/HHcWKMOpzAGoH8saEkE=;
 b=i+a4nEFH+HxnnxVGiMW4hv29QV3P2LitX50/vA/VQj2SCO19KR0yTvlfjKNHGfu96b
 o3tTWJ4nc9C5XClvIPUqWqAXOUQgKkCjid+t0K4ZbqjS7q6ELy7uaoquYEZ4eHqCu0L4
 sUMJVSo2J6j+pa9gY+VAh93+J7dcFw31Et7yrG7BaAinHM65K9GYxOpZFsDm5lkd6Vvk
 qfIwPsF+xZpy1TFuwqqMSVHJvqn/VwFQvfriHXspIfU2sQs8xDjGPCuglRgbaOTHr+BU
 S/8cIu3eBicduxaERaPwEPl7WQGdPk9DrN+aAXsqhkvZWF7RoU932Isfa7YM6ANk9lyP
 Z+7w==
X-Gm-Message-State: APuU4Z+JrmJLMEWxtABTADUEH+cPu6YaBo9FgT1IORcaBqZycP064Pbv
 VU+lLpyymbp/4ncmX+W4tKPp4FRsjGQ3HxXOz3DHrLrDG8XuRhhiKTN92UPoUPUz38c36t+M1Or
 Fk1wu87haZWMOiwyLDzdGebbv2Fs77fAPu7fJ09eNnA==
X-Gm-Gg: AYBFou1MOEH+xYnYtCvLIf1+ALVwmJ3jT+/6Jew1iEj2KxV7fHjegps8Xe3wiPLt4hW
 5K0L9nkMCmRjK4U1skeR+6gq6IBkIJq8rXRgYVxyuV59tzOfGH2VHqsMe4MaHvHuGf5zCehzfW+
 o5an2rcSZlSh+cf8fniojom040/w83FTjhhrp1JEaa/87J247yfOhO1JJAM4ehDwm7IRYvcVmUi
 uc+msZ9YCY17VNy7VrYxDTm5n/0zagpJnjMUeC4LByU5A6j9jkTO1Zt44e3ktJPqpf4LmNKUl3Z
 tfTSw2j8DfjAycdmnBR4vgA7fi86xxHHCQzg+eDiZ9nGnKn+cHBWdwbtXyZi331ZNZmx1XSuMhM
 lD8Ya1VbYhALSlTAWVJaZYEmOu7SeZU66kdw6YKByoHR5t8j7wrf3rqdy6jAhpCT5rL+k1V3khj
 GctkWLmQjAqBqvxHXLddob
X-Received: by 2002:a05:690c:1a:b0:8b3:28c4:c82b with SMTP id
 00721157ae682-8b328c4eb74mr19913667b3.55.1793870758454; Thu, 05 Nov 2026
 01:25:58 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261103110805.2010679-1-peter.maydell@linaro.org>
 <66a0a4e7-3e3c-462f-9a1e-bed93e9bc3bd@oss.qualcomm.com>
In-Reply-To: <66a0a4e7-3e3c-462f-9a1e-bed93e9bc3bd@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Nov 2026 09:25:47 +0000
X-Gm-Features: AclHuK_umNGV9Qon14ZaR4gk7O4PyX3__KkVu4n5D85CQtb-IV7Ag1hQEsQ_pFc
Message-ID: <CAFEAcA8fHpVS5MhiayhaQ7So5mjv0wmZ7uxUF2bg3GatSGpswA@mail.gmail.com>
Subject: Re: [PATCH] docs/devel/testing: iotests check script should be run
 via 'run'
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 5 Nov 2026 at 08:16, Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 11/3/2026 3:08 AM, Peter Maydell wrote:
> > The iotests section of the testing documentation suggests directly
> > running the "./check" script.  However if you do this then the
> > script complains:
> >
> > WARNING: iotests is being run from outside of the configure-time python virtual environment
> > [...]
> > Please use the meson run script:
> >         /home/pm215/qemu/build/x86-tgt-san-dbg/run ./check
> >
>
> A bit a side question,
>
> Does it bring anything useful compared to:
> ./build/run meson test <this_test or suite>?
> If not, maybe we can remove all this, including the extra doc.
>
> We can also add test suites if that's the missing piece to run a
> specific group of tests.

You'd need to ask the iotests maintainers for that kind of question.
All I'm doing is following the instructions for "how do I run
the tests on block backend X".

-- PMM

