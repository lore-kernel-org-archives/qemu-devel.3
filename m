Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F62D2C544
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 12:18:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Dpd-0006dh-1W; Tue, 22 Oct 2024 08:17:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1t3DpV-0006d5-SJ
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 08:17:42 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1t3DpR-0007Fn-0d
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 08:17:39 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-20c8c50fdd9so40767635ad.0
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 05:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729599454; x=1730204254; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pDp/Y2eog6CI6wiNO2V4c3dsgKa8PTRgB4WH6EUiRiY=;
 b=bRNiu7p7I99HMhuToaIEqamrlr/XII+a5PgFrHgzdDLJyjnwmGFQbcZv9eAz/SDiBH
 1vZmAkUwasnA6PWEASIUzELWssLGPxFE7+STCN1f6XLccRS7HS/WoVULI3IkWwSKNzcs
 Xl82DWO8njP+EIlXAgxuvYIetKiCH7tt/BfTUC/iXaLb3LYKL0hQmIRLEbaY03NXnod3
 H/2qEmWIqbFRt4FvMLvnlaBYu6oootXFsosQTuwN2FZzK/iNtj5mHhBC9ktqboN01VdO
 wrEskevhp2viiLLvtJvS85gzmDbf9rklnhes7KEXHVO4hg4Gi9WWNdrIPXHN5R1ceCNS
 sC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729599454; x=1730204254;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pDp/Y2eog6CI6wiNO2V4c3dsgKa8PTRgB4WH6EUiRiY=;
 b=LXCsfQ723iN3BcZrZ2z9NCYF74MbezjzovFvLYoTDa6mjCHDSYngxgaymnavn0dJGz
 rdbyGlz41DsbUV528iVXvqUTszWkSwMRs7bZ7gqOUwNqSBlXSBullvaufPNu4gp/NaIK
 23noa53q5zzDibO8/Bcmmc1d2uPPzYVnAf6/2XNviQ2Hk21OpC9twSWHgNAG61r+1nHm
 HW4c0gipsikDOkysetltKdlgUap4UxOJykwyg5tI7Alp2bw16GUkh5L2PclNt1aZLmYd
 IlbOQPwQ+EGH5D9ZfTY7uR1QOs/pW8wzJ/NvfrAY8E+EBGpAuwyPQsgXeJqi+MY0D3ZB
 TqRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGambbv/YgGb81k35nAh2hM2Wn0zpw10iaZHerDrvzDPoLu+O8VUPyPghjhaA9logstDCrZgc7Jucm@nongnu.org
X-Gm-Message-State: AOJu0Yyi6zm7aG8WT/dtR/BBhS6MdEs8eFMaNVCDYCZbakzeM5va7q0F
 AEXpcR2iW8DIF4WQIDatvkqtU1ho/HLUsfB0WMdQAk5WF5YiWguCRn6mSrY4H+I=
X-Google-Smtp-Source: AGHT+IHSjpPkH1zkjPG4dJVpIaBtWeuqFl4J7P/iACJGXuxIN5sF2Tx5MPAnczrysp9XTNoYL7IUBA==
X-Received: by 2002:a17:903:32d0:b0:20c:5d5a:af6f with SMTP id
 d9443c01a7336-20e96fc106emr50093525ad.10.1729599454177; 
 Tue, 22 Oct 2024 05:17:34 -0700 (PDT)
Received: from [192.168.0.102] (200-207-104-238.dsl.telesp.net.br.
 [200.207.104.238]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7f0c167bsm41635775ad.140.2024.10.22.05.17.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2024 05:17:33 -0700 (PDT)
Message-ID: <9472465a-c7e3-43bd-a7cc-2f8ec2601df1@linaro.org>
Date: Tue, 22 Oct 2024 09:17:30 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/tcg: Stop using exit() in the gdbstub testcases
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20241021150153.487057-1-iii@linux.ibm.com>
 <CAFEAcA9W6Fb-gvCx268xV+CV7LyWJwCQGqkKFpGQjdT+WiAEUQ@mail.gmail.com>
 <e22adb4e-86a2-43aa-a9f4-2e9f40bb4d87@linaro.org>
 <cd561063296a9e42053d7e1c07cf49617938466a.camel@linux.ibm.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <cd561063296a9e42053d7e1c07cf49617938466a.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x62d.google.com
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

Hi Ilya,

On 10/21/24 16:31, Ilya Leoshkevich wrote:
> On Mon, 2024-10-21 at 16:08 -0300, Gustavo Romero wrote:
>> Hi,
>>
>> On 10/21/24 12:08, Peter Maydell wrote:
>>> On Mon, 21 Oct 2024 at 16:02, Ilya Leoshkevich <iii@linux.ibm.com>
>>> wrote:
>>>>
>>>> GDB 15 does not like exit() anymore:
>>>>
>>>>       (gdb) python exit(0)
>>>>       Python Exception <class 'SystemExit'>: 0
>>>>       Error occurred in Python: 0
>>>>
>>>> Use the GDB's own exit command, like it's already done in a
>>>> couple
>>>> places, everywhere.
>>>
>>> This is the same bug that commit 93a3048dcf4565 is
>>> fixing, but it looks like we didn't catch everywhere.
>>
>> Yep.
>>
>> So maybe now change in test_gdbstub.py this line:
>>
>>       gdb.execute(f"exit {fail_count}")
>>
>> to use the new gdb_exit()?
> 
> Thanks for taking a look! I think I'm already doing this here?
> 
> @@ -62,4 +68,4 @@ def main(test, expected_arch=None):
>           pass
>   
>       print("All tests complete: {} failures".format(fail_count))
> -    gdb.execute(f"exit {fail_count}")
> +    gdb_exit(fail_count)
> 
>> BTW, last news from this issue is that it seems to be fixed
>> in GDB 15.2 [0] (I haven't tried it). However, the fix using
>> gdb.exit(n) is still correct.
> 
> Interesting, I didn't realize this was a bug and not a design
> change. Still, given that the buggy GDBs are out there, I'd prefer to
> have this change.

Yeah, exactly, for my fix I understood it was a design change at that
time too, then there is this fix on GDB 15.2 :) Right, I also prefer
having these fixes in place for QEMU. Thanks.


Cheers,
Gustavo

