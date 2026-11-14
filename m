Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89946606A329
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Nov 2026 10:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JXxgnJSX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSBE3-0003CN-33; Sat, 14 Nov 2026 05:43:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <apolivodaa433@gmail.com>)
 id 1xSBDy-0003A9-5N
 for qemu-devel@nongnu.org; Sat, 14 Nov 2026 05:43:11 -0500
Received: from mail-dl1-x1235.google.com ([2607:f8b0:4864:20::1235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <apolivodaa433@gmail.com>)
 id 1xSBDv-00077s-UZ
 for qemu-devel@nongnu.org; Sat, 14 Nov 2026 05:43:09 -0500
Received: by mail-dl1-x1235.google.com with SMTP id
 a92af1059eb24-1b244fb7fffso2086403c88.1
 for <qemu-devel@nongnu.org>; Sat, 14 Nov 2026 02:43:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794652986; cv=none;
 d=google.com; s=arc-20260327;
 b=AmNMomWf46ZtkGwGbs1ihnaqeWp4bMwjSV2kBJJGFZDsl0x2XyeSiKmUA8C0wFOKlN
 +/AV37N3PEUlyVXMAJrLe5Qpdor0Uy8znxps0KLJ3zXI/e3l1Ukzo1ZdjkQ9vb4AYp9X
 gi6L2ZvxVYZ1NhNqPNaYw2x6tkNJE6NfacskhaBNSdNn3cHbBryN2GrCs2Uuf9L7Se66
 obpeZFIKBmvzKXFKNQqL/9MPoHncBSpHd5LiMOn+cskRu/ovm1XwaFTmGSnD1oWxsXCJ
 XwbFFIZtEjBhMpQGgCVkJeV7JQMAlXdTuz9nW8ez5yytoW2AYE+2fZ8poo2IOaq51EaH
 y7/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/ADWD6tJxO6MzTHAiKYPwP3/XnSpuIocnasxTP6OWaM=;
 fh=/Pt0b92rDoVpYvnnVsLqmz9TGe5X+esC+TfYy8MznQU=;
 b=kH2KCwMZtUQSX4kKS9zBQ8NbYKY9R05CtOP/AOhLVJHv2aW1+k6wNjwLZraSwUXFEn
 2fmOFc0/O9Hy4aDWZGFYswcmPX7HRLXZyoJ56wze9Ljbi4hV7lkvTOsG8x9QQktKYVOP
 6SvZCz1eRLzmvA6fP/39jPvHJ0e3ywccsyCnbLSVhbhmcTKP9Fyw+L7OYTt5CDz9rZfz
 Vblrp5KSJdb+2cBg93z97JUz8XzE3bCaIEmer6kTKTHe6sUCdZCe+daFxYNH+R/mNEi6
 txITSwQmOlFrtxNFxmorsN4e7x7/tOHZPtPq38FSp8lAc1zBM/PTfoRIbMY98gPj4jj0
 s1EQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794652986; x=1795257786; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/ADWD6tJxO6MzTHAiKYPwP3/XnSpuIocnasxTP6OWaM=;
 b=JXxgnJSX7qS4O0G29DXkr/AYEneWxQlHtlQf5XzikxR9KXCS04eeT86ATpjjc7P2kp
 t+KGvLAvyB1ElpxR2hDCZtqamUlGSPGWWQih9mbTLeXSr+A7G8sjYAiaHGsmOyQwFIEH
 j6v1mjMbs6C6CR7JpgQAeUjo1kRwqy0IiK6xABJTTiCzo54TN6kADZFn61bG80FUvOHj
 DOOsS3zYiQk1WL08yoabNDiDjfS+aNocyiRbiME/NL3KwiRSYizSCfGa/i8TbLWq18S7
 5VgXmVVZuWCNyKV0yJArQ82cdeoKKc62zJbTMV5CLG/AP2lHrmfX/xvcsQlBnkltkQOt
 YC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794652986; x=1795257786;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/ADWD6tJxO6MzTHAiKYPwP3/XnSpuIocnasxTP6OWaM=;
 b=hhUTdkWmykDpULhSkMWvBGxPhrs+xFV0nfSUrIB8/65nj9xFuCRjc0oXK4Re1kqUrA
 9YyJeyqxhF5pREic40NhNT6tgSNS9gMaOggWOACz5VFHX7x6TQP6XPuET7Fz1y1LK9ir
 I5Hg5ZiOubmlXkfUQWfgQVfnkhppQjsCr/iyS9YAjJoaxQE4iAv2LYGbx1BkwV9Ii2Lk
 VW7Im8w0p+rYWMNBoK0idssL5DZzh3iHk6xE+cfvWUfd0szzxY1VJoG7dnXIc5EbLTV5
 j1npMR4Rtc8diDScRgKpy7FCUkfB+EryfLke2JiY6RF6yZukU5EPV/oZuCvbxVu85jVL
 +ufA==
X-Gm-Message-State: APuU4Z/YlflJxHIKqoDzUF2XatofJlbbiLkoI8aasdMbwH0JfwgGRJN0
 m5TAu4B6kqGTwKMA/Q3n6f+vV79ymuoCW8NXtg7dbGtkRf6xlM6WxGCjfZ8zB56j6gazCEZczeb
 whWrPUClxtjZAALUokj/8LlHwExkNC7g=
X-Gm-Gg: AYBFou2ejikywJz9VZe7Vx531DQsuuWmIoPhDsNL9DwYxx5S8YwZyzSlRN9e4It0/xB
 9ZOw6lPM14spEQH/tLokFI+ZNqJQo53C0IY6eF+A2aJ3kNKEI35sbbKhuSZ+iKwzHI8AEI+yXHM
 BJKL5qwATIR/5EH9WCb5GIRrcaT43Unb4oCItNcJwbxBzpg1+gHEzluaxt9BzdRWiFZMOOi19uq
 ie+G+2YNTJPFVXKSFbH9fRxA5V4jfxSVAWHUCjsc7swlz92GXrJHGPUvedL7GMpclC6qPI+9pcI
 EUGYEFNUpIqQCXA6mYRJ1y7m0Cznx5H/azNRDR4vVqAt7zA7iXE3P5ZA1bFugMBONYKRAUHqew7
 0iaPsVQRI+MzeoainudosRM9hOCkfNWbCNE6AlbApUfRpLFEWjfB74jCmTF+KX5DlOlFx
X-Received: by 2002:a05:7301:1a0b:b0:36c:9e26:88b6 with SMTP id
 5a478bee46e88-37965ca86fcmr4754269eec.9.1794652985478; Sat, 14 Nov 2026
 02:43:05 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261109181839.1042836-1-pbonzini@redhat.com>
 <CAGscdFsT3dUnZ53JrnwgNog8b48_8cS5kBoOjcRAP6x7dgsquw@mail.gmail.com>
In-Reply-To: <CAGscdFsT3dUnZ53JrnwgNog8b48_8cS5kBoOjcRAP6x7dgsquw@mail.gmail.com>
From: Andrey Polivoda <apolivodaa433@gmail.com>
Date: Sat, 14 Nov 2026 20:42:54 +1000
X-Gm-Features: AclHuK9ewhb_Ays1THTUI95SgK_STJnG-K1ekQNJQrLHPhe4aU27vP-IudHQpVQ
Message-ID: <CAGscdFtN8kxpcVpz_9HAydL4wH5Fo3oG1Y9Xi9D-9PvyhQGKyw@mail.gmail.com>
Subject: Re: [PATCH] target/i386/tcg: all scalar instructions should be LIG
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1235;
 envelope-from=apolivodaa433@gmail.com; helo=mail-dl1-x1235.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Tested-by: Andrey Polivoda <apolivodaa433@gmail.com>

Test code I used
```c
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <sys/mman.h>

#define PAGE_SIZE 0x1000ull
#define CODE_SIZE PAGE_SIZE

static uint64_t execute_vex_opcode(uint8_t* code_page, const uint8_t* opcode,
                               size_t length, uint8_t out_ymm0[32])
{
    static const uint8_t prologue[] = {
        // mov eax, 0x5aa5
        0xB8, 0xA5, 0x5A, 0x00, 0x00,
        // vcmpeqps ymm0, ymm0, ymm0
        0xC5, 0xFC, 0xC2, 0xC0, 0x00,
        // vxorps ymm1, ymm1, ymm1
        0xC5, 0xF4, 0x57, 0xC9,
    };

    static const uint8_t epilogue[] = {
        // vmovdqu yword [rdi], ymm0
        0xC5, 0xFE, 0x7F, 0x07,
        // ret
        0xC3,
    };

    if (CODE_SIZE - sizeof(prologue) - sizeof(epilogue) < length)
    {
        __builtin_trap();
    }

    memset(code_page, 0xcc, CODE_SIZE);
    memcpy(code_page, prologue, sizeof(prologue));

    size_t offset = sizeof(prologue);
    memcpy(code_page + offset, opcode, length);

    offset += length;
    memcpy(code_page + offset, epilogue, sizeof(epilogue));

    uint64_t (*func)(uint8_t out_ymm0[32]) = (void*)code_page;
    return func(out_ymm0);
}

#define OP(name, ...) \
    { name, (const uint8_t[]){ __VA_ARGS__ }, sizeof((const
uint8_t[]){ __VA_ARGS__ }) }

int main(void)
{
    uint8_t* code = mmap(NULL, CODE_SIZE,
                         PROT_READ | PROT_WRITE | PROT_EXEC,
                         MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
    if (code == MAP_FAILED)
    {
        perror("mmap");
        return 1;
    }

    const struct {
        const char* name;
        const uint8_t* code_bytes;
        size_t size;
    } opcodes[] = {
        // 1. VF(N)M(ADD/SUB) (VEX.L=1)
        OP("vfmadd132ss",  0xC4, 0xE2, 0x75, 0x99, 0xC0),
        OP("vfmadd132sd",  0xC4, 0xE2, 0xF5, 0x99, 0xC0),
        OP("vfmsub132ss",  0xC4, 0xE2, 0x75, 0x9B, 0xC0),
        OP("vfmsub132sd",  0xC4, 0xE2, 0xF5, 0x9B, 0xC0),
        OP("vfnmadd132ss", 0xC4, 0xE2, 0x75, 0x9D, 0xC0),
        OP("vfnmadd132sd", 0xC4, 0xE2, 0xF5, 0x9D, 0xC0),
        OP("vfnmsub132ss", 0xC4, 0xE2, 0x75, 0x9F, 0xC0),
        OP("vfnmsub132sd", 0xC4, 0xE2, 0xF5, 0x9F, 0xC0),

        OP("vfmadd213ss",  0xC4, 0xE2, 0x75, 0xA9, 0xC0),
        OP("vfmadd213sd",  0xC4, 0xE2, 0xF5, 0xA9, 0xC0),
        OP("vfmsub213ss",  0xC4, 0xE2, 0x75, 0xAB, 0xC0),
        OP("vfmsub213sd",  0xC4, 0xE2, 0xF5, 0xAB, 0xC0),
        OP("vfnmadd213ss", 0xC4, 0xE2, 0x75, 0xAD, 0xC0),
        OP("vfnmadd213sd", 0xC4, 0xE2, 0xF5, 0xAD, 0xC0),
        OP("vfnmsub213ss", 0xC4, 0xE2, 0x75, 0xAF, 0xC0),
        OP("vfnmsub213sd", 0xC4, 0xE2, 0xF5, 0xAF, 0xC0),

        OP("vfmadd231ss",  0xC4, 0xE2, 0x75, 0xB9, 0xC0),
        OP("vfmadd231sd",  0xC4, 0xE2, 0xF5, 0xB9, 0xC0),
        OP("vfmsub231ss",  0xC4, 0xE2, 0x75, 0xBB, 0xC0),
        OP("vfmsub231sd",  0xC4, 0xE2, 0xF5, 0xBB, 0xC0),
        OP("vfnmadd231ss", 0xC4, 0xE2, 0x75, 0xBD, 0xC0),
        OP("vfnmadd231sd", 0xC4, 0xE2, 0xF5, 0xBD, 0xC0),
        OP("vfnmsub231ss", 0xC4, 0xE2, 0x75, 0xBF, 0xC0),
        OP("vfnmsub231sd", 0xC4, 0xE2, 0xF5, 0xBF, 0xC0),

        // 2. Individual vex_lig instructions (VEX.L=1)
        OP("vmovss (0f 10)",  0xC5, 0xFE, 0x10, 0xC1),
        OP("vmovss (0f 11)",  0xC5, 0xFE, 0x11, 0xC8),
        OP("vcvtsi2ss",    0xC5, 0xFE, 0x2A, 0xC0),
        OP("vcvtsi2sd",    0xC5, 0xFF, 0x2A, 0xC0),
        OP("vcvttss2si",   0xC5, 0xFE, 0x2C, 0xC0),
        OP("vcvttsd2si",   0xC5, 0xFF, 0x2C, 0xC0),
        OP("vcvtss2si",    0xC5, 0xFE, 0x2D, 0xC0),
        OP("vcvtsd2si",    0xC5, 0xFF, 0x2D, 0xC0),
        OP("vucomiss",     0xC5, 0xFC, 0x2E, 0xC1),
        OP("vucomisd",     0xC5, 0xFD, 0x2E, 0xC1),
        OP("vcomiss",      0xC5, 0xFC, 0x2F, 0xC1),
        OP("vcomisd",      0xC5, 0xFD, 0x2F, 0xC1),

        // 3. X86_VEX_REPScalar instructions (VEX.L=1)
        OP("vsqrtss",      0xC5, 0xFE, 0x51, 0xC1),
        OP("vsqrtsd",      0xC5, 0xFF, 0x51, 0xC1),
        OP("vrsqrtss",     0xC5, 0xFE, 0x52, 0xC1),
        OP("vrcpss",       0xC5, 0xFE, 0x53, 0xC1),
        OP("vaddss",       0xC5, 0xFE, 0x58, 0xC1),
        OP("vaddsd",       0xC5, 0xFF, 0x58, 0xC1),
        OP("vmulss",       0xC5, 0xFE, 0x59, 0xC1),
        OP("vmulsd",       0xC5, 0xFF, 0x59, 0xC1),
        OP("vcvtss2sd",    0xC5, 0xFE, 0x5A, 0xC1),
        OP("vcvtsd2ss",    0xC5, 0xFF, 0x5A, 0xC1),
        OP("vsubss",       0xC5, 0xFE, 0x5C, 0xC1),
        OP("vsubsd",       0xC5, 0xFF, 0x5C, 0xC1),
        OP("vminss",       0xC5, 0xFE, 0x5D, 0xC1),
        OP("vminsd",       0xC5, 0xFF, 0x5D, 0xC1),
        OP("vdivss",       0xC5, 0xFE, 0x5E, 0xC1),
        OP("vdivsd",       0xC5, 0xFF, 0x5E, 0xC1),
        OP("vmaxss",       0xC5, 0xFE, 0x5F, 0xC1),
        OP("vmaxsd",       0xC5, 0xFF, 0x5F, 0xC1),
        OP("vcmpeqss",     0xC5, 0xFE, 0xC2, 0xC1, 0x00),
        OP("vcmpeqsd",     0xC5, 0xFF, 0xC2, 0xC1, 0x00),
    };

    uint8_t ymm0[32] = {0};

    for (size_t i = 0; i < sizeof(opcodes) / sizeof(opcodes[0]); i++)
    {
        if (opcodes[i].size < 3)
        {
            __builtin_trap();
        }

        uint8_t byte = 0;

        switch (opcodes[i].code_bytes[0])
        {
        case 0xc4:
            byte = opcodes[i].code_bytes[2];
            break;
        case 0xc5:
            byte = opcodes[i].code_bytes[1];
            break;
        default:
            __builtin_trap();
        }

        if (!(byte & 4))
        {
            // VEX.L=0 for some reason
            __builtin_trap();
        }

        uint64_t rax = execute_vex_opcode(code, opcodes[i].code_bytes,
opcodes[i].size, ymm0);

        printf("%-14s RAX=%016lx YMM0=", opcodes[i].name, rax);
        for (size_t j = 0; j < sizeof(ymm0); j++)
        {
            printf("%02x", ymm0[sizeof(ymm0) - 1 - j]);
        }
        puts("");
    }

    return 0;
}
```
```
$ clang -o vex_lig_test vex_lig_test.c -g3 -O0
$ ./vex_lig_test > i3-6100_output.txt
$ .../QEMU/build_dbg_nosan/qemu-x86_64 ./vex_lig_test >
qemu_with_patch_output.txt
$ sha256sum qemu_with_patch_output.txt i3-6100_output.txt
dc6754edacf0ce9f16bc47fd4fb8242ae662021360f05a9e524de2fb90b119d0
qemu_with_patch_output.txt
dc6754edacf0ce9f16bc47fd4fb8242ae662021360f05a9e524de2fb90b119d0
i3-6100_output.txt
$ cat i3-6100_output.txt
vfmadd132ss    RAX=0000000000005aa5
YMM0=00000000000000000000000000000000ffffffffffffffffffffffffffffffff
vfmadd132sd    RAX=0000000000005aa5
YMM0=00000000000000000000000000000000ffffffffffffffffffffffffffffffff
vfmsub132ss    RAX=0000000000005aa5
YMM0=00000000000000000000000000000000ffffffffffffffffffffffffffffffff
vfmsub132sd    RAX=0000000000005aa5
YMM0=00000000000000000000000000000000ffffffffffffffffffffffffffffffff
vfnmadd132ss   RAX=0000000000005aa5
YMM0=00000000000000000000000000000000ffffffffffffffffffffffffffffffff
vfnmadd132sd   RAX=0000000000005aa5
YMM0=00000000000000000000000000000000ffffffffffffffffffffffffffffffff
vfnmsub132ss   RAX=0000000000005aa5
YMM0=00000000000000000000000000000000ffffffffffffffffffffffffffffffff
vfnmsub132sd   RAX=0000000000005aa5
YMM0=00000000000000000000000000000000ffffffffffffffffffffffffffffffff
vfmadd213ss    RAX=0000000000005aa5
YMM0=00000000000000000000000000000000ffffffffffffffffffffffffffffffff
vfmadd213sd    RAX=0000000000005aa5
YMM0=00000000000000000000000000000000ffffffffffffffffffffffffffffffff
vfmsub213ss    RAX=0000000000005aa5
YMM0=00000000000000000000000000000000ffffffffffffffffffffffffffffffff
vfmsub213sd    RAX=0000000000005aa5
YMM0=00000000000000000000000000000000ffffffffffffffffffffffffffffffff
vfnmadd213ss   RAX=0000000000005aa5
YMM0=00000000000000000000000000000000ffffffffffffffffffffffffffffffff
vfnmadd213sd   RAX=0000000000005aa5
YMM0=00000000000000000000000000000000ffffffffffffffffffffffffffffffff
vfnmsub213ss   RAX=0000000000005aa5
YMM0=00000000000000000000000000000000ffffffffffffffffffffffffffffffff
vfnmsub213sd   RAX=0000000000005aa5
YMM0=00000000000000000000000000000000ffffffffffffffffffffffffffffffff
vfmadd231ss    RAX=0000000000005aa5
YMM0=00000000000000000000000000000000ffffffffffffffffffffffffffffffff
vfmadd231sd    RAX=0000000000005aa5
YMM0=00000000000000000000000000000000ffffffffffffffffffffffffffffffff
vfmsub231ss    RAX=0000000000005aa5
YMM0=00000000000000000000000000000000ffffffffffffffffffffffffffffffff
vfmsub231sd    RAX=0000000000005aa5
YMM0=00000000000000000000000000000000ffffffffffffffffffffffffffffffff
vfnmadd231ss   RAX=0000000000005aa5
YMM0=00000000000000000000000000000000ffffffffffffffffffffffffffffffff
vfnmadd231sd   RAX=0000000000005aa5
YMM0=00000000000000000000000000000000ffffffffffffffffffffffffffffffff
vfnmsub231ss   RAX=0000000000005aa5
YMM0=00000000000000000000000000000000ffffffffffffffffffffffffffffffff
vfnmsub231sd   RAX=0000000000005aa5
YMM0=00000000000000000000000000000000ffffffffffffffffffffffffffffffff
vmovss (0f 10) RAX=0000000000005aa5
YMM0=00000000000000000000000000000000ffffffffffffffffffffffff00000000
vmovss (0f 11) RAX=0000000000005aa5
YMM0=00000000000000000000000000000000ffffffffffffffffffffffff00000000
vcvtsi2ss      RAX=0000000000005aa5
YMM0=00000000000000000000000000000000ffffffffffffffffffffffff46b54a00
vcvtsi2sd      RAX=0000000000005aa5
YMM0=00000000000000000000000000000000ffffffffffffffff40d6a94000000000
vcvttss2si     RAX=0000000080000000
YMM0=ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
vcvttsd2si     RAX=0000000080000000
YMM0=ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
vcvtss2si      RAX=0000000080000000
YMM0=ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
vcvtsd2si      RAX=0000000080000000
YMM0=ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
vucomiss       RAX=0000000000005aa5
YMM0=ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
vucomisd       RAX=0000000000005aa5
YMM0=ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
vcomiss        RAX=0000000000005aa5
YMM0=ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
vcomisd        RAX=0000000000005aa5
YMM0=ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
vsqrtss        RAX=0000000000005aa5
YMM0=00000000000000000000000000000000ffffffffffffffffffffffff00000000
vsqrtsd        RAX=0000000000005aa5
YMM0=00000000000000000000000000000000ffffffffffffffff0000000000000000
vrsqrtss       RAX=0000000000005aa5
YMM0=00000000000000000000000000000000ffffffffffffffffffffffff7f800000
vrcpss         RAX=0000000000005aa5
YMM0=00000000000000000000000000000000ffffffffffffffffffffffff7f800000
vaddss         RAX=0000000000005aa5
YMM0=00000000000000000000000000000000ffffffffffffffffffffffffffffffff
vaddsd         RAX=0000000000005aa5
YMM0=00000000000000000000000000000000ffffffffffffffffffffffffffffffff
vmulss         RAX=0000000000005aa5
YMM0=00000000000000000000000000000000ffffffffffffffffffffffffffffffff
vmulsd         RAX=0000000000005aa5
YMM0=00000000000000000000000000000000ffffffffffffffffffffffffffffffff
vcvtss2sd      RAX=0000000000005aa5
YMM0=00000000000000000000000000000000ffffffffffffffff0000000000000000
vcvtsd2ss      RAX=0000000000005aa5
YMM0=00000000000000000000000000000000ffffffffffffffffffffffff00000000
vsubss         RAX=0000000000005aa5
YMM0=00000000000000000000000000000000ffffffffffffffffffffffffffffffff
vsubsd         RAX=0000000000005aa5
YMM0=00000000000000000000000000000000ffffffffffffffffffffffffffffffff
vminss         RAX=0000000000005aa5
YMM0=00000000000000000000000000000000ffffffffffffffffffffffff00000000
vminsd         RAX=0000000000005aa5
YMM0=00000000000000000000000000000000ffffffffffffffff0000000000000000
vdivss         RAX=0000000000005aa5
YMM0=00000000000000000000000000000000ffffffffffffffffffffffffffffffff
vdivsd         RAX=0000000000005aa5
YMM0=00000000000000000000000000000000ffffffffffffffffffffffffffffffff
vmaxss         RAX=0000000000005aa5
YMM0=00000000000000000000000000000000ffffffffffffffffffffffff00000000
vmaxsd         RAX=0000000000005aa5
YMM0=00000000000000000000000000000000ffffffffffffffff0000000000000000
vcmpeqss       RAX=0000000000005aa5
YMM0=00000000000000000000000000000000ffffffffffffffffffffffff00000000
vcmpeqsd       RAX=0000000000005aa5
YMM0=00000000000000000000000000000000ffffffffffffffff0000000000000000
$
```

Thanks,
Andrey

