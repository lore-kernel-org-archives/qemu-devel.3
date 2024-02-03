Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C65C4828F
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Feb 2024 11:45:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWERn-0001g3-Eq; Sat, 03 Feb 2024 06:44:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rWERm-0001ff-Q1
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 06:44:34 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rWERk-00066o-9p
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 06:44:34 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40fccd09082so6510725e9.2
 for <qemu-devel@nongnu.org>; Sat, 03 Feb 2024 03:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706960670; x=1707565470; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J7i2eVmx3bgBKTW0/dA1vFA1Ra0CFTZkkFTgcLaocM4=;
 b=HIM2mzELh+qSovOMIoxlRWD6nG25fBZytQ4+dsPiDZwK/oIyIcWLgC7jXQYQBlX9YK
 FYUoFSDVlT8yAZ1ItD/u463abQO0YQzriLW/EcuhkeRMWm/ahegm9J3fs3TiELqECfY1
 cXsIhIQ9t6hNkmkI1/hfyqUicbLUqVWRtBGS9rUx21FLdKu33L5eNRdl4pQmY1AMFB3S
 G0ERqxtZGOEXYwJ6hyJa3oQhpH2tVpMvsWFuXYNv3wBoCy6XS7b6+1m8snhm9fP5I6/X
 z4wYUJdXtNPGD99RRcuv7bMmY2J1BwCyQGtw1wIDtxh2IEnHiVBwpPo+O3m5XjY07A2X
 33ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706960670; x=1707565470;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J7i2eVmx3bgBKTW0/dA1vFA1Ra0CFTZkkFTgcLaocM4=;
 b=LQtpgGqJPvqc0q/u1dtsSR81McIGoIRp+g81WqKOL5YJijNw3O0XqYrxi+6n4haR/G
 RHoGGxce0GD1fgmeVxYFeIf3InfkdZDKIOyuvOcBmkTGbyt31RsxCaZzY7EDGHUE9o7N
 e72+LvSSJwxB0lvxySfxC5QpWN+bfBoGIbFUd6Jdh7Nmo7SazOy6Ol1oQfO/g9ZaizhJ
 Dx9XYcs1ERH6C16o2p5tGglPVeKf+wUIWYl/NmaZ2wbm9H3Ja7rPDeJeLvbmaX4IUp1z
 6h3Xj2Kgk94dzFv3JRJxno82viiGTB+Cwe/RBoTsZkfL1GdTvUi7MscqPQ0z/qaF2LYZ
 fgXQ==
X-Gm-Message-State: AOJu0YyFHIjO1tZEPLZlisMP1IAU1uZvk7gwIoOciF9pjkdhG+DEvNWz
 KhhnqIsQ+DwOdsuyFIbraDC0NViNF06g0KM+nvhAopeR5k8NCiiwl0rZHVTHEog=
X-Google-Smtp-Source: AGHT+IEBLqHjQHdStMPIfTOV2hRjujiZ+Ur/yvN7cwiIHGwYCKyLU7DUja4U7oQrbkNg0VCJhfGtrA==
X-Received: by 2002:adf:ec02:0:b0:33b:2326:5142 with SMTP id
 x2-20020adfec02000000b0033b23265142mr2583318wrn.13.1706960669907; 
 Sat, 03 Feb 2024 03:44:29 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWOjB+MbAchR7jaNpDzLGcatmt9xJy2EZzefqQOW3rcLVp0VxdDGRvt1FNSL++FSbr6/nolkbnFzMUc9PInbcm9VA+o88XM88OoPFbqG7EniWRg9NQ1iv/16badwiKZza4bKTzAnqyazLlkQM7/HvYHKju/lzuMvVHggk7A6vffBI9VY2bWdbZtsB53UcqrbttBKaLb6kNfaythwn4ennkRFX5nFReVbe8cwnrNdXSBEtXb4oePw7glrtdhjbljEIKaL6fvuU2KnFYiLefUa/2bVrlS9r3/Bw+VtfjGVYiFo2T72OHMxqnyzsY5b8x2ccG/VufB0nLekrPJKHGma+Sou1ZcFkndSLrLFr3hlK8inwFpiRA9gTbbWumRd7K7AYhsdztMZCYmYEYq/csdWADJDSZx/+QtSSuSjjox4redsEXMVme59wYgDQvRbSlKv9+lxb69ArxYz1ktvYPR9064vQ0KE4/dvFFmLNVZpYqAaKQahtEHT6HP9iWK2khnjo0+Ef2a9usXJq6etSf1QgfybnWs+6Q6Bah2MFhAd3O6RbOgYPHm2Co8FDaucDhAWa4olZ+5oZ3BQ5G2q5lkqu7+2JhM8KcrffaIEM4/QaYsjIntLFtz3gHMRHTUdcKO+yjD9xz1ufSN2dObcT1k7P+HVKeWW1pYWj4AFtiPQgMRx6CTEVIygg83RogTRoiol4ySrxdmsvg46DQ2XBxfENjENutLbU/C27HE6vX1VDF4s11IdNFwyIuqpT7thZmHC3afZGUaxa311N3K6xsRdJKV5Lpi7s6PRxBZjuBVKAkrGzP3sACBobcc7D9vRLZF8pLK9U8z8k5p6ZGLj0ublVTuuebv3fhkVGfxfUmhspkjMTr/cV3x+IN55Ue81xiwZmt/peO/puTUcMbeVcqZo8kC28UUan4Uz6lwcRLnJGWYnk0M7EJqelxJKlSIjGafx7aLf8
 UdBasNsIoPsBDxz4u0Iitm3boftlZRaV5eIOibH3LBgQ2XwIEMtIgfHdSeLaj+PaG7Qp4y0XibYmseXzulbTJkVQVEayr+evC5IUyiYu7vmhM3XuxTHdDT52XHG7JCA4u10WJFNWlpjOU20SQyScTUMBXS3gft7qOJImc7BzTONBnGVv44tf5PJVknK+rO0aaj806/uM1//oVmG+2XAbcF/ChA2MKFRgqGX9QaDqKbZLBuFisZKIzezv/URo6HmlqumzLQSRI3XVY6eCpEL0l8ZJb5h+a48UYKgLyYr2xW8+aHL5LX3alIVi/gU9/9R999T826
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 y4-20020a056000108400b0033ae593e830sm3894552wrw.23.2024.02.03.03.44.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Feb 2024 03:44:29 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 177825F7A9;
 Sat,  3 Feb 2024 11:44:29 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,  Philippe =?utf-8?Q?Math?=
 =?utf-8?Q?ieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Michael Rolnik <mrolnik@gmail.com>,  =?utf-8?Q?Marc?=
 =?utf-8?Q?-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  Laurent Vivier
 <lvivier@redhat.com>,  kvm@vger.kernel.org,  Yoshinori Sato
 <ysato@users.sourceforge.jp>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  Palmer Dabbelt <palmer@dabbelt.com>,  Liu
 Zhiwei <zhiwei_liu@linux.alibaba.com>,  Laurent Vivier
 <laurent@vivier.eu>,  Yanan Wang <wangyanan55@huawei.com>,
 qemu-ppc@nongnu.org,  Weiwei Li <liwei1518@gmail.com>,
 qemu-s390x@nongnu.org,  =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Peter Maydell
 <peter.maydell@linaro.org>,  Alexandre Iooss <erdnaxe@crans.org>,  John
 Snow <jsnow@redhat.com>,  Mahmoud Mandour <ma.mandourr@gmail.com>,  Wainer
 dos Santos Moschetta <wainersm@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Ilya Leoshkevich <iii@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>,  David Woodhouse
 <dwmw2@infradead.org>,  Cleber Rosa <crosa@redhat.com>,  Beraldo Leal
 <bleal@redhat.com>,  Bin Meng <bin.meng@windriver.com>,  Nicholas Piggin
 <npiggin@gmail.com>,  Aurelien Jarno <aurelien@aurel32.net>,  Daniel
 Henrique Barboza <danielhb413@gmail.com>,  Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>,  Thomas Huth <thuth@redhat.com>,  David
 Hildenbrand <david@redhat.com>,  qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Song Gao
 <gaosong@loongson.cn>,  Eduardo Habkost <eduardo@habkost.net>,  Brian Cain
 <bcain@quicinc.com>,  Paul Durrant <paul@xen.org>
Subject: Re: [PATCH v3 16/21] gdbstub: expose api to find registers
In-Reply-To: <1c9a2e94-0c54-446b-99a2-69e25e9725df@daynix.com> (Akihiko
 Odaki's message of "Sat, 3 Feb 2024 20:23:46 +0900")
References: <20240122145610.413836-1-alex.bennee@linaro.org>
 <20240122145610.413836-17-alex.bennee@linaro.org>
 <1c9a2e94-0c54-446b-99a2-69e25e9725df@daynix.com>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Sat, 03 Feb 2024 11:44:29 +0000
Message-ID: <875xz5pyaq.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> On 2024/01/22 23:56, Alex Benn=C3=A9e wrote:
>> Expose an internal API to QEMU to return all the registers for a vCPU.
>> The list containing the details required to called gdb_read_register().
>> Based-on: <20231025093128.33116-15-akihiko.odaki@daynix.com>
>> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
>> Message-Id: <20240103173349.398526-38-alex.bennee@linaro.org>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>> v3
>>    - rm unused api functions left over
>> ---
>>   include/exec/gdbstub.h | 28 ++++++++++++++++++++++++++++
>>   gdbstub/gdbstub.c      | 27 ++++++++++++++++++++++++++-
>>   2 files changed, 54 insertions(+), 1 deletion(-)
>> diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
>> index da9ddfe54c5..eb14b91139b 100644
>> --- a/include/exec/gdbstub.h
>> +++ b/include/exec/gdbstub.h
>> @@ -111,6 +111,34 @@ void gdb_feature_builder_end(const GDBFeatureBuilde=
r *builder);
>>    */
>>   const GDBFeature *gdb_find_static_feature(const char *xmlname);
>>   +/**
>> + * gdb_read_register() - Read a register associated with a CPU.
>> + * @cpu: The CPU associated with the register.
>> + * @buf: The buffer that the read register will be appended to.
>> + * @reg: The register's number returned by gdb_find_feature_register().
>> + *
>> + * Return: The number of read bytes.
>> + */
>> +int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
>> +
>> +/**
>> + * typedef GDBRegDesc - a register description from gdbstub
>> + */
>> +typedef struct {
>
> nit: Add struct name; docs/devel/style.rst says struct has a CamelCase
> name *and* corresponding typedef, though this rule is apparently not
> strictly enforced.

I think the wording is a little ambiguous here, especially with the
reference to typedefs.h where the anonymous structure typedefs are held.
In this case we don't need the structname because there is no internal
reference to itself.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

