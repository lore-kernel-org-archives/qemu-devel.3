Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B1DC87FCB
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 15:41:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujJlI-0003q9-KJ; Tue, 05 Aug 2025 11:39:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ujJcU-0004qf-17
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 11:30:35 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ujJcR-0000iG-Np
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 11:30:29 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-61589705b08so12260261a12.0
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 08:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754407825; x=1755012625; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GTyv+N2DVqkdxVPEClPIDYuLYuX1aiW7piSBtCyujS0=;
 b=dnRvE5MjvnyLDUabdoqMwlfG7cRrcE3gDpbNALMbCj+bqKcLZ6ZUEVmalJHcJ9UAsz
 Y6ZRAQmIMU8NZN0ZeuQFUYJfVqmXQ982Icaq7YZbTJYQF1bfisLaRvkhf88KGs9LP8G+
 DUO3/wFC2hKEbDEfdXmbrebhD+zTd02lvFr5Yt6PwDLY8kRpX7Wzdv/7XgLyVC2DKfjy
 nerIFp59pvM9sqZWdMiVe2woelTf25smDEiDtDwA0plcLgKnBfcOJv03gp1gkYlYjjm/
 wJfqrgXkeEBbZuYrJrCnOtE4c53AJvsLJyWTMnpCNgJv1a0RG9HyDwpKtET7DVFlWdBV
 QJmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754407825; x=1755012625;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GTyv+N2DVqkdxVPEClPIDYuLYuX1aiW7piSBtCyujS0=;
 b=jHVnWERcD9IOjVOHQUMR/vJALY2zoXlYexhp/VyFmmManbujRR+xTS7OJg3LEW/f6W
 3xmzgivCnOph/hfln4ONuUWd7IejoPLoTXDeO7ke+JL00qHKITM+84Ij19m0nDfLUCQM
 X0vPGkgDJwAaOEDC5Ru4iBqnbaRb9QrjiWqjXLGkoDRPWP3rGszW9Bfysocc62BB+NOb
 jNrB9uO8nsh4mjlM06+bUJOYoopyAdfFIAbMYcWDL+n2dinne9RPLknDc0iAtG7qiuim
 7X+ZxRhCZjblNeXy0vkn8JH9BS1glX5vAbWxgsmfferqwDc8vQ1H03Wigq+Jqioc6kHN
 gL+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUn84byVGwBSLVmnOsxg79w1LJJ+hvDLGJ+dnE1SLgJOaK1ZgEv31j0qJSuy/PD2soGjrdOQFVG/I50@nongnu.org
X-Gm-Message-State: AOJu0YwlL5SyRTYIQcGsOeItmFpEBamBixOSrDdpc1nZHrzTW+19CA1s
 NEz6EJnSDEreqAsjdFhBjn9HuElZ6kPmv4/hHXiL+d2NjcfQLxpOCC5MACcxXxwnlNE=
X-Gm-Gg: ASbGnct8qAdryN/yHyEkSnXbU2RQVLA/TwB/HRH11FuCopfWNUPCXwKyaX55Nfi2ojC
 KXgKGDOHaskKXX2z42TY0kwt/7FTdgFifL8CtfYMOxopdnaE7BhZ2QZgfBcfLqCBmpo4cF9Tu19
 8Atw08AnPU04mFPSzqnX3mur4Zf69WKO1ubHmVz+PgPC4QSNNAC9VJDlU709xoXB9Jx3hhRRrYO
 FYkw9VYPreUU+kkE6QIjglusKMdwnmA1cebIb+LK3nkTh0OnxNobhBL4v21CVKQnUGPvd8Oi3nK
 KAo5M14DS81feoFBTtNtC/bHEw4mBkcDyNhoBWZkuVRzLVT9NiRbZJ4gZ29M4nttXeIlrDfm0d4
 alYYofZqnGUkYzUZm21My2Sg=
X-Google-Smtp-Source: AGHT+IG7MlMy5zb25Ieqk9wtJfLU/L/7Eh41D1maOgpY+n4h7o1MxeqfnxqF6LrfzhGVuayAFkBuGA==
X-Received: by 2002:a05:6402:274e:b0:615:db4:74dd with SMTP id
 4fb4d7f45d1cf-615e6ed217dmr12705974a12.13.1754407825319; 
 Tue, 05 Aug 2025 08:30:25 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-615a8effda1sm8506325a12.1.2025.08.05.08.30.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 08:30:24 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 651295F7E9;
 Tue, 05 Aug 2025 16:30:23 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Florian Hofhammer <florian.hofhammer@epfl.ch>
Cc: pierrick.bouvier@linaro.org,  qemu-devel@nongnu.org,
 richard.henderson@linaro.org,  laurent@vivier.eu,  imp@bsdimp.com
Subject: Re: New capabilities for plugins
In-Reply-To: <73d56742-5e6e-4e1f-8d8c-2b9783d0ddea@epfl.ch> (Florian
 Hofhammer's message of "Tue, 5 Aug 2025 16:30:09 +0200")
References: <205e6753-53a4-4739-99ed-26344403a437@epfl.ch>
 <87tt2n5az1.fsf@draig.linaro.org>
 <1016eeb7-57d8-4d80-ba25-42cda2d63b0f@epfl.ch>
 <874iul26rp.fsf@draig.linaro.org>
 <73d56742-5e6e-4e1f-8d8c-2b9783d0ddea@epfl.ch>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Tue, 05 Aug 2025 16:30:23 +0100
Message-ID: <87y0rxzsz4.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x536.google.com
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

Florian Hofhammer <florian.hofhammer@epfl.ch> writes:

> On 05/08/2025 16:16, Alex Benn=C3=A9e wrote:
>>>> Another option would be to have a set_pc function that would restart
>>>> the execution at new PC. Then the vcpu_syscall_cb callback could set
>>>> the PC to post the syscall with whatever state it wants to set up.
>>>
>>> Such a set_pc functionality is already covered with the register write
>>> API, as long as I have a handle to the PC register, right? Please do
>>> correct me if I'm misunderstanding something here!
>> Ahh we should make that clear. It requires special handling as the
>> PC
>> isn't automatically updated every instruction. For analysis this isn't a
>> problem as the TB itself knows the vaddr of each instruction so can save
>> it if it wants.
>> Currently if you write to the PC it won't change flow - and it will
>> likely be reset as we exit the syscall.
>> c.f. https://gitlab.com/qemu-project/qemu/-/issues/2208
>
> Thanks for the clarification, I haven't fully thought the implications
> of updating the PC on the jited code through.
> Do I understand correctly that this would likely require hooking into
> the TCG in a way so that the target address of this set_pc function gets
> retranslated?

I think to read the PC we would just need to make sure we properly
resolve it - internally QEMU does this for faults with:

    tb =3D tcg_tb_lookup(retaddr);
    cpu_restore_state_from_tb(cpu, tb, retaddr);

where retaddr is the address of the translated code. We just need to
special case PC handling in the read path.

> While I've dug into the QEMU code quite a bit already, I'm
> not sure I'm familiar enough with the TCG internals to be able to tell
> whether such a set_pc function could determine the address of an
> (arbitrary) already translated block. I.e., if the target PC is not just
> the next instruction after the syscall, can QEMU determine whether the
> target address has already been translated and if yes, where the
> generated code actually is located?

No need - we just need to exit the loop via cpu_loop_exit_restore() and
the code will do the right thing. However we probably don't want to
trigger that via register write as we would surprise the plugin -
especially if there are other hooks still to run. So we would want an
explicit helper to do it.

>
> Thanks,
> Florian

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

