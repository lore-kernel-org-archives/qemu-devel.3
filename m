Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A82C44501
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 11:17:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjEeW-0006sK-Ls; Mon, 13 Jul 2026 07:16:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjEeT-0006ri-S4
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 07:16:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjEeS-0007Rc-7D
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 07:16:45 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DASOX9507024
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 11:16:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xyErPye3cFw9bWjqscackmWoqS9hSImRguTgCL92V+c=; b=oV2htQlcnyRpUOfP
 YPRcldT64hGiVbzsbn9nFvbUo5J5z7zMM16npeleCkOP+vlcJ8bKEa4C/q9i7wLw
 Wh3YTIeoEbUgMEZDCIZz0wqJkC4YGefgzyo2H9gIEHTh4X6gENdAa21Hg1o4Eho2
 AZ5XbVvhxgR5FPY/9tkFzZRHKH8cFjC0ausbEwRQxgoYFLY5msAnYGkkXtNFCfsq
 oyPFcvm0/SeXcIuCbf47guqJwgkCAajh7JvIVpi6/Pw/EoYPtEYG8e5kEg5xYVnV
 tFd7UkMUYkoeZkQdQAUlLeWnHPN/zxnsTGiMPZ9t+Zm7Xwun0v6KPVbu8VxzSQ3f
 OoJ8wQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fctc8h70y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 11:16:41 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c0ab07320so37681991cf.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 04:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783941401; x=1784546201; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xyErPye3cFw9bWjqscackmWoqS9hSImRguTgCL92V+c=;
 b=Q5Re9/kP5ou8GWTyFHAYuD/MQiSxp9XJ0skzkSmzjiQ5FRgxADnMFbXAB1VvSU/Myw
 zDo8cVJxPCIzAv091ZDHkOxZBaDG44u+MScdOPru+sIQyEZDY3yCoTvM7CLC8TpuSPIO
 Gstkl9xNCfVeY+tYRcuHdH+J42IoVv7Zeqi2whdSbmFU6fv2z90blDeTK6QZcC8Rrsmx
 bmx3SpBnT1i4KD1PNqpDEYSEqMbaSXVcH+yLctlKRNjoGWFGO/qSEy3nD6bBYc1IHM6k
 xzwMLxBaxEG5TB3TG2+GMo1UAdnIjNd1ndvkXsaGnkMYY1v3UGJoMGx85SdjY3AImfa8
 q4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783941401; x=1784546201;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xyErPye3cFw9bWjqscackmWoqS9hSImRguTgCL92V+c=;
 b=MKqF9qxh51j193Zv1z0p+hNsdzgQc6JEyrBevn3LLJNbJ+WPNs+foSYCL8q9XQTbXc
 cq89OSZUTixPT+ciKTpmxPcsrHkqvXmijkgBUEXx31Aa8ZYuKpDafYM0jcvWv3XsiCaR
 zGk0H8akq8HroC663PwR0V4XUrlQCf+jDliFAcwKO69kK+p30yfroa7vLLn+6qAWZevR
 aunmI7Lv0TZ4C00TiKa7k0dZJZog6CLtO8mMBdogNfJfNzcW6r2BJkObzbPWxIzmcZ9L
 VQCIJuiO6rzHr2VA4yOrYxHE0Ugyrv2Kbm99hwdYS+D18EiuCVLmTPd/VhCemNeC+6F7
 fGJQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoYMWMjjdwSCiixt6HRvHXF0QbilNueExxF/ilsnXZWpOXMFi4kReGvDjN8X+3t9GuKRFZYqCfg+X4j@nongnu.org
X-Gm-Message-State: AOJu0YzDdqUAzK9ewta8Ul0gF/fDPsfjKdCml/CoEsZ1RnQqBcBUmiF9
 mvp6C39ETE4XZtBbVp0ZwTp63QMwdYSuwES9DCAZE2V/6N/6ZPl7LZmb4egefziPLnvWofVAukj
 6P+zl0uUEc+NXvkPmjb74XtZnBwWD8WpP3EV6D3d+IW8tVKEWiiDICoxAOhjPq9f4lg==
X-Gm-Gg: AfdE7cloDBt8xFJHhjdE7VziwASLAHN8dHqo60wodMmKC/bZUbGdiU52vvnh9CsbjR4
 02DlP+nOPwNDoAgVfqWjqOOXD0fbjbaQdBEkBZnnf9o3NPTec0Pn5Q2GkQwI1A+MM7B1W6xNJm/
 JGGNOX4PKZJbLkKnjJSEkY+aotBVO8SKgsor1ftCtLw6rAptgu07q5O8c7xHQ7/fQjButOFWrPg
 LxgA9shBclto5oC+XHEShxg79mLKOCdVGGu8XNsTVT1FOGL3YFIf6afLlxdl/6aw5o8JFOUubzD
 qKuEvWtHpbJsnbpDrI1MwEIZ2TSkL9d4DpuOdK0FyovUi8q7NgCiYKcGmNWpa9t10CDmKCd6ZM6
 3fgYpWAjYGif6PwlT9/xjCnVrFees3HAGnB41nomUB1dujqcMi/46mA/Nt4oFNg==
X-Received: by 2002:a05:622a:552:b0:51c:963:cafc with SMTP id
 d75a77b69052e-51cbf3153b9mr81924881cf.41.1783941400629; 
 Mon, 13 Jul 2026 04:16:40 -0700 (PDT)
X-Received: by 2002:a05:622a:552:b0:51c:963:cafc with SMTP id
 d75a77b69052e-51cbf3153b9mr81924691cf.41.1783941400292; 
 Mon, 13 Jul 2026 04:16:40 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d8410sm85251462f8f.15.2026.07.13.04.16.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 04:16:39 -0700 (PDT)
Message-ID: <37cd41d4-cd36-420e-b6d7-a0bcc1590b96@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 13:16:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] ui/input-barrier: fix off-by-one in keycode bounds
 check
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260706-fix-v1-0-4b83a70e9f3b@redhat.com>
 <20260706-fix-v1-5-4b83a70e9f3b@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260706-fix-v1-5-4b83a70e9f3b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: VCZju68ZJqiHEPkOSrjUj5w2EF_GRtln
X-Proofpoint-ORIG-GUID: VCZju68ZJqiHEPkOSrjUj5w2EF_GRtln
X-Authority-Analysis: v=2.4 cv=UtRT8ewB c=1 sm=1 tr=0 ts=6a54c919 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDExNyBTYWx0ZWRfX6TFCTDvG1o6x
 3K5M4Dece0Cfw1yGnWm7T7UWPDbjaV3dQc5p6yMfE9WmcRUSCd3Kre/GH2scecHEjF4VMNbq43k
 sgntoAk9Mrkxv4OGfnibUtLn80ydVPI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDExNyBTYWx0ZWRfX3fQZZqpR1jR2
 sfC8V8qPgLKdB2S4z+lU8YEtw3W8pPVHBVo6se8MZoXNlAKrgEbVBvKgciGuyKDZ46p/aM17f5X
 caADmuL/dvDxXYI7xCKQcXsZskYrykqZLxUrkF1rq1fYOQyHnU9Bt29l1U+ZD7rBsIHwSz9MWHI
 DlFfWhHL4F2ANwqnHT/i/AaLQrf2yQc1MmFR6HkI5xPxd97g/ozJtN25yaKfpYYwQ80cvAwb0uX
 HXtgNWY/ho0lnAoTo/qawO9pi3rV1FBCl30/Lqt4Ges0ohVbrMWrzENTOvqV+vT3b7B0IDuqlZ9
 uP6vbNJ/P6Eg9bosrVYP27KsFbFfFwNhheTkS3QmpVGotVa3PkgNKp6KOJyhjrBe2ZNbC7HQrk6
 OJI9ZluXL+/ft5AMRYcyE37P4Lude5COhpHfuq5TGmbIFwXyBj0jvwyhfe7qUF4xXT98iNqJXnw
 jcZhL9qOmEzyEou309g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130117
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/7/26 14:53, Marc-AndrÃ© Lureau wrote:
> Use strict "<" to fix the off-by-one.
> 
> Fixes: 6105683da35b ("ui: add an embedded Barrier client")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3951
> Reported-by: huntr bubble
> Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/input-barrier.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

