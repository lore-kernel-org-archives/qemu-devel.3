Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5253A606A319
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 15:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Mzlfkr36;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hHCTVL9E
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJBkb-00045E-PT; Tue, 20 Oct 2026 11:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xJBkV-00044p-Ql
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 11:27:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xJBkS-0006Nn-Jp
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 11:27:34 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KDA4vU2845836
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 15:27:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 j00bfTyg4T8iRpBjv1lDlw93ie7C5sBXyUyFWi26jGU=; b=Mzlfkr36VQRIPTx7
 HJB9smohh3GM86sae3QyawnY7ODLG9SeVcz+4R10fbENDiSzrZ2C07jqStbiXQ8H
 9JLHq+fQ5nsgpeABaOesAULN4cULuxiCTmTVPYIKHsqfwH0aCQT3Sw7TzdkGdx1k
 kthdEv5a4zl2XHGiYMJBdxLF5NTqQofLj2JpMWJW9KDjaD0h2jlmafNr3Zv9WOZZ
 g2M1/yPSyvPhU4KAX8iBURy5odHym+WH3gjXIyb0kZZF/yrnPNeQQKBMNWzk1FrM
 z4tuhjOwba0CD/+sWyleOSLt7Uzj/fAkA0cTm/VibAcoCFJ7dA/Qy+DW+en2Q+JW
 KXkufw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5nb3rr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 15:27:29 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-91b8306ba68so80867926d6.2
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 08:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792510048; x=1793114848; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=j00bfTyg4T8iRpBjv1lDlw93ie7C5sBXyUyFWi26jGU=;
 b=hHCTVL9EyuoVZoVnfxfj1Jj+AahoaOO1FWGqKS3tXaLVst5+cwm3qg11+hb+HUQz9X
 1R/Y0ZZ1ZCERBDifgSm6unj+KHbOrz3B5O9/BHdLgSfPDkiL/kCwPnBtG/e1WkE4aIz7
 WK5oghJDnunAydBj4WS+HCd0W5EJM4REF9WxAUEUtjSFB7gHjM7TZl4GlpS90giepYTz
 SJwsewatpa+XoUshhxVpRrjjthrXbS3JHGsj/jfZLGSG2jyZDF3TS9AZshSoMOfKs+Rj
 N5FMCPkWOQ0WnH+0hn7W5LmlxREkotTVwYID1emqg0/279PsF03JFjSrA89T9xhNZ/4c
 6gSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792510048; x=1793114848;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j00bfTyg4T8iRpBjv1lDlw93ie7C5sBXyUyFWi26jGU=;
 b=yVhhL+Br2VMn2xVAR2CwAA0+ma8LXTNMjRpDnKUFW+UUS4nju+2/fafNIQNnpsZ+nI
 dzIVoeDmXsnxiiae0hBC+pAFVMprSZyy/QBh/5kOuNYnIgi0wVBs5OSX3Hp2r24JzjKx
 4JuWCDNbu/IvZ7h6tpP0oqThGnIgeDk1Fc1fIhataPH+xOg9PsIJB6TRuhoRC+klWnJX
 BmL0ZoeN31QBZKXpiR0gGrnKtvX2JozIXJlgFY8OBTJ/ogXvbZ4beFbQ90j9lp4DqrCH
 /IWGp++z4pZJRkIXIk4rl+4h1TYtAiLEMWj/R9sn7PBk9ZIlD19BbkcKNwntGSFca3Sf
 aEHg==
X-Gm-Message-State: AFq9FYJYdKZC2urG/8zA+uE/0nVNobuF6ze4bFtbRA/2Lcq6ZADCDj5L
 SrXptFI25UV+sA07qaE2iDgYyXJok5Kl9F3LmJQkyAtO0lRt8qyarkX8Hl5mt7g2XTSHUkl8Rc9
 hS6gRNzbxMfWUGitpxC75KHcQ9v+vtH85IW3lr/PCd46Xjg6HQeXmLoFONQ==
X-Gm-Gg: AYBFou2rcX8BadeyHVOdZvWyzi4v4gnCo+Dw1Uc/FrSALPEQe30tUY0MDwzHZ85evGW
 mC0lrZq/+Vzethm4uGXS/fQec7jUiR2842BCGDZfC3q8GUup9voep0OMmnP1Zr4kH8IJWZw+ewg
 QdkNy1SIKxgyUmSnJnKFQRGRgOQnS8qFwpTBqVSoQde230fHPMCDwvQawL3KbiqESSZYgcxHIoi
 scHwLr+/pHd1E81ESS1DuaFvjRdor47mwyPK6THknWNsPUDxYrPuhRLOZubrohjaHhA4QLHlJ0S
 +n0j4lEGJ9Ncogatc1iSSkL46k9WBZhTfPcPzHaQ/mmQR/I2OspApMO1j7sVaNfpTzET7bslVHs
 P5+Me0YSmRnBEEDu6gph7Wn7sfsUQmJmNHzibhCvXyekWV8wa9trQ5vgO1/hFjIdE
X-Received: by 2002:a05:6214:5541:b0:914:4464:41b8 with SMTP id
 6a1803df08f44-91bdf095c77mr190585506d6.12.1792510047857; 
 Tue, 20 Oct 2026 08:27:27 -0700 (PDT)
X-Received: by 2002:a05:6214:5541:b0:914:4464:41b8 with SMTP id
 6a1803df08f44-91bdf095c77mr190584956d6.12.1792510047107; 
 Tue, 20 Oct 2026 08:27:27 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c10bd5d8csm724696d6.24.2026.10.20.08.27.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 08:27:26 -0700 (PDT)
Message-ID: <41f6dc3f-f172-4de7-b839-cff727f726a5@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 10:27:23 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 2/3] tests/tcg/hexagon: add slot-assignment tests
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260806213640.699905-1-brian.cain@oss.qualcomm.com>
 <20260806213640.699905-3-brian.cain@oss.qualcomm.com>
 <CAFEAcA8CYaJ=jAyc29RSdUMD_SWquJqz4fNQyW7oCrWithZhYA@mail.gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <CAFEAcA8CYaJ=jAyc29RSdUMD_SWquJqz4fNQyW7oCrWithZhYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: MAetH6EWVB03kHbbsqc5LuSXGDzBvZFz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA2MSBTYWx0ZWRfX37kCzbElk/Tm
 Nk9AcjcpZcEFx+S9JGD4SWrgAfMsbwaJlxFPGm0SZLxTbfGbkav1rXBmmJBjaT9CqPmnGMJ3Oop
 ZNn1Lh9LXMKXGOyH5G5HT5uQBRdXVB5KO3U2M+UtsVB1NOcGeZFeD9tchJ6YYJgJd9gADkvJCL6
 lHkJqYdV12pp3sLYe0EcQvAMafUPA9eW2NxtwUPAsJV7RNCxIwqGUV+m5QICFCGQ9gsUZu5sa5P
 /dDaET+O5mMJlO/j3O644e6MTa9iZZbYiphq+k1Rtl9559QA4V1ByUOL/yoR5OLq+EH5ZhFv/T+
 PXMmVo5HWjGPMXLMH6tSgvBp5Byh1FIQhR/8EZ17acDsuSmx7gERZWZ9gcA/xm3wy0nqURfsyMx
 sni4Ns7AtVRkqy5FpOaSuLEh1gTjqXm+6ZJAsykqc4FsIRN4S24D6CPfGBdpERttT7UNW9Ni+xP
 h0crAu2UFYrVSqo0/Eg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA2MSBTYWx0ZWRfX3ZWJGXR8mPK9
 cqO9AQgaq47/KA2a9wzkVtpHmFN1n2LhfC2oTt3x29BB/ZK5pOUWgOlzF1gsFYxmM2HzOKM6VYS
 mQD0s5dyIMxJZuOPnw+OSEqIFpqWvww=
X-Authority-Analysis: v=2.4 cv=VI9IDNPX c=1 sm=1 tr=0 ts=6ad78861 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ioWAfrCCVwa-FguC9LgA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: MAetH6EWVB03kHbbsqc5LuSXGDzBvZFz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200061
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/20/2026 8:45 AM, Peter Maydell wrote:
> On Thu, 6 Aug 2026 at 22:37, Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>> valid-slots: packets that legally share a slot and were wrongly
>> rejected before the fix (load and transfer, load encoded first;
>> dczeroa packed last with three transfers).
>>
>> invalid-slots: unassignable packets that must still be rejected:
>> store + duplex, load + indirect jump, three logical ops competing for
>> slots 2 and 3, and five ops for four slots.
>>
>> Reviewed-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   tests/tcg/hexagon/invalid-slots.c | 72 +++++++++++++++++++++++++++++++
>>   tests/tcg/hexagon/valid-slots.c   | 62 ++++++++++++++++++++++++++
>>   tests/tcg/hexagon/Makefile.target |  1 +
>>   3 files changed, 135 insertions(+)
>>   create mode 100644 tests/tcg/hexagon/valid-slots.c
> Hi; if you build QEMU with the clang sanitizer enabled
> ("--enable-ubsan --cc=clang --cxx=clang++") then the invalid-slots
> test added here results in the hexagon decoder trying to shift
> by -1, which is UB:
>
> $ UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1
> ./build/clang/qemu-hexagon
> ./build/clang/tests/tcg/hexagon-linux-user-invalid-slots.test
> ../../target/hexagon/decode.c:603:35: runtime error: shift exponent -1
> is negative
>      #0 0x555695dc2392 in decode_set_slot_number
> /home/pm215/qemu/build/clang/../../target/hexagon/decode.c:603:35
>      #1 0x555695dc2392 in decode_packet
> /home/pm215/qemu/build/clang/../../target/hexagon/decode.c:783:14
>      #2 0x5556959801e7 in decode_and_translate_packet
> /home/pm215/qemu/build/clang/../../target/hexagon/translate.c:1274:18
>      #3 0x55569597f927 in hexagon_tr_translate_packet
> /home/pm215/qemu/build/clang/../../target/hexagon/translate.c:1375:5
>      #4 0x5556958bda32 in translator_loop
> /home/pm215/qemu/build/clang/../../accel/tcg/translator.c:216:9
>      #5 0x55569597ec72 in hexagon_translate_code
> /home/pm215/qemu/build/clang/../../target/hexagon/translate.c:1428:5
>      #6 0x5556958bca00 in setjmp_gen_code
> /home/pm215/qemu/build/clang/../../accel/tcg/translate-all.c:251:5
>      #7 0x5556958babd7 in tb_gen_code
> /home/pm215/qemu/build/clang/../../accel/tcg/translate-all.c:324:21
>      #8 0x55569589fbfc in cpu_exec_loop
> /home/pm215/qemu/build/clang/../../accel/tcg/cpu-exec.c:973:22
>      #9 0x55569589e309 in cpu_exec_setjmp
> /home/pm215/qemu/build/clang/../../accel/tcg/cpu-exec.c:1019:12
>      #10 0x55569589e10d in cpu_exec
> /home/pm215/qemu/build/clang/../../accel/tcg/cpu-exec.c:1050:12
>      #11 0x555695977cdb in cpu_loop
> /home/pm215/qemu/build/clang/../../linux-user/hexagon/cpu_loop.c:38:18
>      #12 0x5556961fe1f5 in main
> /home/pm215/qemu/build/clang/../../linux-user/main.c:1010:5
>      #13 0x7c65f202a1c9 in __libc_start_call_main
> csu/../sysdeps/nptl/libc_start_call_main.h:58:16
>      #14 0x7c65f202a28a in __libc_start_main csu/../csu/libc-start.c:360:3
>      #15 0x55569582d294 in _start
> (/home/pm215/qemu/build/clang/qemu-hexagon+0x910294) (BuildId:
> d18c0fb84fd3431a52be6d831fc64fd2d0e00980)
>
> (This also shows up as "make check" failing in this config.)
>
> Could you have a look at what goes wrong here, please?

Thanks - I've now posted a v3 of the UB fixes series w/a fix for this one:

https://lore.kernel.org/qemu-devel/20261020151720.728888-4-brian.cain@oss.qualcomm.com/


>
> thanks
> -- PMM

