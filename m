Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5389606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AcHFhJsN;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OrQKcyTq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMquQ-0003eg-3i; Fri, 30 Oct 2026 14:00:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMqso-0002Aj-Ii
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:59:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMqsm-0008TK-ON
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:59:18 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UHu5MR3430785
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:59:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Pu8+7VefQUDC3SJKE4np9xKxjD+bROI9jxnlmyFSeWk=; b=AcHFhJsNUQXcqjKb
 OiS/q2AqMphLJDXE/+WwmJwODFeWg87GujVxLcVbAwutt9GnHajAJzPyINhVEjH1
 LwNQEdvZndtFYyYCwkqixrbJ0f53b/pkx5a11Z67hGXjnAikFBM4JHbO+qrP4oK/
 4zQAgmUeUhLveO7XasJnT7uN2YtQ7gWFsjAI0lovqrCvmx9DUtbzW37M2iQuvAZv
 xuY+AMkhI8VhFs10VbUZo97stskuoSUAWT/AfCA8tG8oHySBgOPUdDPNKPqjTtc9
 6WhMpVfcLMLclQzPJzmzcmOUYdFD8XwEXa2lJGfIFHtsa7Z1DMBluEcD20AjG/Ju
 NZti+w==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qmc7j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:59:15 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-36a190c53a3so1297766eec.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 10:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793383154; x=1793987954; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Pu8+7VefQUDC3SJKE4np9xKxjD+bROI9jxnlmyFSeWk=;
 b=OrQKcyTqrAN+hWQGhlYHzz+z5vCyLxMvuU4DqU8+HrByz76klhDQuaxshz2k/t3x/b
 Ce3VPDajCpvx8Ih2luCy4OeFcDH3V+765sma/GCulsBStoKfdXCbdFbMrvPYCYK7qxzy
 t651fkFJxPC9AcVaYZlB7Xth86hcoauff+a0R8TJmA1WfWYs9HendnMfSbucp5UUdlbk
 0BliQcamR6cYoAfJUovYAVQFhBHAdyKZHYhYD4FeHTNXl4DW99rR8PEla6F0F4j8Mdro
 FurbWnfvlNEYkHew8zFC6v14N7d9qavqR1IIthxJOb1LVwOjeMOFraoNVC5fC0isC5KD
 8Wjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793383154; x=1793987954;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Pu8+7VefQUDC3SJKE4np9xKxjD+bROI9jxnlmyFSeWk=;
 b=wTTO7xbSWUp7dCKlYPMB5QRcZqoMLwIzPjllmnckhwA9RUgc4NUVGdN5TGOkI2jL3e
 wnw52rJTwpxZumCmMU8o5HOywoopPvFNXfLNeVbfGDqIAplwFvWiuc2Ui6wEcJqbtrAR
 Uh8VVo9ILGtDcCu1T+/2GqR8jPMOSVk2X7khN8ymXkIxPp5QmPlj10hNwAr+Yj42pstM
 //G3yXaDCuijluJWpZej5SGY95Xo8qLOdIOVuMG1fIgYVGHFqSTpVuIE2kz8cmgAtJR8
 PmT0HDg0kP8r6oLTyOXjYeflI4b6BgkCUtZOtXav6iXV0TxPWr+9HEW1gB8EOm+H8iD7
 ioWA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxXxRdRV2QxwT8BVSiej4kkdWiC/+k1wZV4iDdfwLTYVU7tboiA5uI20ns9qcTidKoMUrSDblGJbypv@nongnu.org
X-Gm-Message-State: AFq9FYJfvL9EbZfNMSTM0m0OMBiJSckuGyrpkHZTwDyrCPwQgJD0d7oy
 dX30xGt8AeeWpKxuA/q7OHDlPsPLhvJnQsG4tYUSesDX6oJjhXnaJUylAPPHFAwiAa6VWwav3r1
 Yh1J8puGQPN+sMvDF11rLFw4Fo6VNZpmbVWxKxM1BQU6SAW6VpNx4fiy0GQ==
X-Gm-Gg: AYBFou3tEmWoyhX4quw9ySnl0hgCUavX6nE3Z8ll6pPz/eD1LpYWS/5qGXkER3J/ioi
 LGHkdu8FBKOhhhhlQuI/q2FdcYjF+tcNoTbzkN854cSYyIEdgM1Pt7ypNzercz0IyeD/FBvsqCk
 lEkiGFbU/06fu18bPDZsqF0XWZjGgqPe3nnReQVYvAb+eLb3lVaEyspro4mesKkBfFOFv7v8jpB
 9MKImjxXQ1jM/eS72/QLvh3oAVLrU07cLnPilYyrWp3+IuT5z8EE4Akt4focfxt+Xkb0bov3p3A
 KCdHyE0iDQkqacBUrPD8OCmGGh5Y63AtTLUvWePgUitnKL1TjA/1NvODzWMSPLIvd5qzM991L+1
 XACuKUZxnb5c0jjP6qLjd2GBfedwTUE2qWaFoiSURbOMlTfK8Os9txKLZQwMkeG5sYOzt2sy3Ys
 NRB1eSPfOcRx4XoqVzlhw5GjE1I/9jGwdWR9rPYdB7TwA=
X-Received: by 2002:a05:693c:61dc:b0:36a:1a7b:d1bb with SMTP id
 5a478bee46e88-36a300756bcmr10377702eec.22.1793383154344; 
 Fri, 30 Oct 2026 10:59:14 -0700 (PDT)
X-Received: by 2002:a05:693c:61dc:b0:36a:1a7b:d1bb with SMTP id
 5a478bee46e88-36a300756bcmr10377662eec.22.1793383153759; 
 Fri, 30 Oct 2026 10:59:13 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42902649sm9898940eec.11.2026.10.30.10.59.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 10:59:13 -0700 (PDT)
Message-ID: <3348be46-6b62-47a4-9590-0a0aef261707@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 09:59:12 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/32] tests/tcg/mips: Remove unused test_utils_32.h
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20261030175357.99684-1-philmd@oss.qualcomm.com>
 <20261030175357.99684-2-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261030175357.99684-2-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfX1x9oNVYddIzj
 wE2JaXmVBX98erTvheTz10kJUj8GGq7Mb+ybFd1YH4DpUV0OY1ciqrTnOb4jmtTBnq4BAv9vMNq
 wJbsu7ZjEs7BN/a1LyJb64dZffaCLo48D09nYj+u8BdcraaOoAf/9B/lgRV55FtCXDmUB3cNmxo
 JA5UrFmqnaf93MMbj4qWeQ1idOiS95G26Ue+YpgrzCWFYiyXGJtr4FTHhBCnzg8TLWnkosVef7J
 SYZo+q/Ek2+4rO6pxNK7IMW2YOdhnyMvmggQKhhvKxH1TYkJEH3grMIGa84YSlKAKgIPa/LE3T8
 TZ7OKvd0D8hSRrj0H1isZUNPLSLXVkdlV+14dIalKWYi7EfvKLSwtjILrRvpcAmNcQcTyJm6H9Q
 T3S03zqbIcMGJEx6Mzod2DJVWFTztVtbeaBLEvoGv1/C2DM+kcj7Ui+TwdNDDSCGIYR5tz2Nf6+
 H+aIL0i8sS4k2DKFV2g==
X-Proofpoint-GUID: 2T6pM7rb7lvpHA10t-jnUuKE9v3_TAtd
X-Proofpoint-ORIG-GUID: 2T6pM7rb7lvpHA10t-jnUuKE9v3_TAtd
X-Authority-Analysis: v=2.4 cv=IumL47/g c=1 sm=1 tr=0 ts=6ae4daf3 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=KAK_GFpBjN3eYroQ7JUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfX/3rHd6h5Rf7h
 +ybJHHfX9zKEEi7EFfqVMp/SxBTnIxUKhKShgs7ztuyWXBDzf9uqVn9+CAb3pIs5VrSlrpAQgKq
 yRGa90loUP94u5loSEWU+MsHvOFqorI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300071
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 10/30/2026 9:53 AM, Philippe Mathieu-Daudé wrote:
> The 32-bit test utilities header added in 26b3256392e0 is not
> included by any test, and check_results_32() is never called.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  tests/tcg/mips/include/test_utils_32.h | 78 --------------------------
>  1 file changed, 78 deletions(-)
>  delete mode 100644 tests/tcg/mips/include/test_utils_32.h
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

