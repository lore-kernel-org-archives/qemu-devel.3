Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF941039881
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 19:58:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw3yp-00005N-LZ; Fri, 27 Feb 2026 14:58:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jithu.joseph@oss.qualcomm.com>)
 id 1vw3yh-0008SL-F5
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 14:58:26 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jithu.joseph@oss.qualcomm.com>)
 id 1vw3ye-0007mx-ME
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 14:58:22 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61RH0I1l1912521
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 19:58:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6sC5JrJcrlfE/LAMh1DpWEeXWD+LUE8oTL/gPCOyY/s=; b=jIAqPzfVGU2j6Mbj
 Z5ir2JtwKaIILIJ7rlLPgtw6diodfGqT7k1xCAgWUT4So7KfHfBSAvbVbq19/A0l
 ddx+Sorb95CIlnIM4e15tYcjKlizRew2wGhIvRyiALgKAxGGpW8iuC3DdDq5tjEJ
 uwzn4H9EHZSzUw17SEXQIPa1IG1Rf77nFBP3AFXRi1gD3Bq3+1l8BvBDkjfrf0CS
 Ey1rSJRpFbcyBPF1tRSOT7YQ2wVu8KGZ7L7xqgk9P1Ksi+PYUCdrY3Fzqdorg5SZ
 x3NLIWiUuUwucNBfeitjW45EBb5Qd0r6gWnu4gJt0O25YW12gWpN+8QLHiw2hJ5b
 C8GqkA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjuur4deb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 19:58:18 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2bdd4ce8dc3so2244747eec.0
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 11:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1772222297; x=1772827097; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6sC5JrJcrlfE/LAMh1DpWEeXWD+LUE8oTL/gPCOyY/s=;
 b=RMnzHpttJ/JOWt+feAC9UgWfkMp8uO4MpKL44HcmWHVyO3jlRKBQ6yYZEl22D/qj1T
 BODCW4vKgYyiqgJJ2cLN/+i2i0Z3INqKu/QIv1HYVtkKu33KWzlwsOintJ/ueDRkTfv0
 UYI7SC6QHNksgeFgeHjx25Dio0BcCOQhzYjoIapq4ypzDhF+OFng+deR/20t9tudhkV7
 L1Tz/tMzz1pe4nEsLhrrwODWhjq+iSgMnKLlqWZKKGMqMHF32Cf8hJqOmLiNxGe6tUsn
 RkoWRfv+stfKXLK+Ifo4sY8ARQJb+jSpuDM5ExxA6wzBHFS1fKnGSl0yRB++YZMd08vm
 +8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772222297; x=1772827097;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6sC5JrJcrlfE/LAMh1DpWEeXWD+LUE8oTL/gPCOyY/s=;
 b=ZDgi2Qu2oS5mfomPdN0PsVeisqui8ZnGA0kQ9V8lh8wXqkjKVHEFPm7siMP58iOoDk
 uv9t1ApmWBGGvYB2l0quqAFj4Ljmb/xq7Zda1TM9HC35/vN+uPLx4QokjawchPGIEbjx
 AWRZZDwlqoBr/KPVUkbEkiTNOhyuPv0Lkp/YWjsYTkEB/OvsgNiuNS/Kx8FmAP8vD2qg
 dfzdvQtmhobZcQSwAUOZ0ZnWt/iiGsGlBGRRQcykKhaUAwnsSx5SeAST7SWwlGWZb9K9
 Q58xQIfgyRilNMZNVWydeTqTKXp5Jmyq+gUoyDZ14K0pYOV4wG2aCS+Ew+zYhTfy3Et7
 TW2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvwAf+09ljsmY2SAUBXZAVArc1GinydcbKKD3KS3RYgPmZUJ7eBgX1X17s3FMcv6k5Y1RlwCy1jT6A@nongnu.org
X-Gm-Message-State: AOJu0YyL7X6q3JMrCYucBAjcLXjYD87ARCTPJA+vONppukVQ8EQp/t8m
 T55q3GgyQEeM67SC9ZYVOdz1TJQYI7B2Y4mPMkeCU5LicYfkTEcIjOu3lhkvnjHrMyEtnU9CL/m
 OfFMwVI+McUcrwBk9nbDuQUVRTo7D1hIdL4PJ2M6uVY2ywNevpRhfxyBsWl+lNy4zjA==
X-Gm-Gg: ATEYQzwQupgmViMseY31eofpe/E/+zJUIMzuQr/0q6JsGtR/v1KgpdWd8ecCZ7/Zwpr
 xF7KVOpSBGvPUUnHyvm+PPiXySQhyU5VKi7H4cDWklPg09DHcd7LWJ2ZvruYCBrwBFqMqxbe7tK
 gwIJgYkRCt7oAFhfKYsOakmyqGQo9YtW6fTjyGB43d++Xs7iRn3CSTKxPTojA7kk76ax6V5Ns4s
 m1nPxC31TH7Ff2IsJEbCKFhD9+fDV9ex6nzHibWZ1QvpZqbGjdWP5kOTa9owb9GjMDOduwentS7
 1ssJK9+6V720vj1RBVPgVHyivGHyKPMP+Nch2lbZoLh18y2/IQYVxH5gcVT0IcNMpjS0+ZPtw8b
 AS/w+ADT9nDu/pboGWU/sYjs+3tmlZ1hVIi4w1KP06emC84IgOXl10tuhy8L/5+Fw8Ie7zNYUlI
 qQ1g==
X-Received: by 2002:a05:7300:72d0:b0:2b9:dde1:33e0 with SMTP id
 5a478bee46e88-2bde1c0f805mr1736215eec.2.1772222297167; 
 Fri, 27 Feb 2026 11:58:17 -0800 (PST)
X-Received: by 2002:a05:7300:72d0:b0:2b9:dde1:33e0 with SMTP id
 5a478bee46e88-2bde1c0f805mr1736187eec.2.1772222296554; 
 Fri, 27 Feb 2026 11:58:16 -0800 (PST)
Received: from [10.110.80.16] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2bdd1bcea4esm4366458eec.5.2026.02.27.11.58.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Feb 2026 11:58:16 -0800 (PST)
Message-ID: <16fcdd24-621d-4cd3-97ad-c45fd4725e31@oss.qualcomm.com>
Date: Fri, 27 Feb 2026 11:58:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 03/22] hw/i3c: Add bus support
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>,
 "komlodi@google.com" <komlodi@google.com>,
 Patrick Venture <venture@google.com>, Titus Rwantare <titusr@google.com>
References: <20260225021158.1586584-1-jamin_lin@aspeedtech.com>
 <20260225021158.1586584-4-jamin_lin@aspeedtech.com>
 <ad58c432-8c9e-4cd8-847a-df4bd6a45d6d@oss.qualcomm.com>
 <897005bf-fd67-4d78-86b4-b92c9cc0f666@kaod.org>
Content-Language: en-US
From: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
In-Reply-To: <897005bf-fd67-4d78-86b4-b92c9cc0f666@kaod.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: JFyzaFsxLLeokKdLql8AkTKZh4UfDV6_
X-Authority-Analysis: v=2.4 cv=PN8COPqC c=1 sm=1 tr=0 ts=69a1f75a cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=uFRWuoFFug6GEp8UtR4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE3NCBTYWx0ZWRfX8OLSUkSEPrIt
 FsJNwjx4PDu6B+NXODxdIBVyfPnqmpB0F1QbQlXZyuw+E78wiMHMkFYtbtYlRuY++kZUREMSE9f
 wuCr5XdqROScfTLlodAJrOIYe2SOj1QnGz55bHJAMfAbHwVfdPIdeu+DlATeVjfuWfjSH/lsOp3
 ezZzqyQ5UossL0n64KOD2tjcIGV4vs5REDRo8LctSGuARSPnvkG5xmicSYnPOCyCrjSphX3/h+e
 Wdi9JCsvyFynjz2iZbj9WtmVtoyZMgLW7/UbW09Hd+8VYC3OoKnYbOGmovAclytCQmGVmrDQm0X
 7ro0V4BclvumsuP7p8xC72o8SPivK2WVsHG4P1Zal0P21BNU+vgIINlbjVhLpp+IXMeEtbnJGoZ
 /rHOuc2UMFUb/Rpx1vSDjaqdUFCT0a/be6LZ5n/mpKEkYnH+ykqpIWGQGTF++55Bv+8OPC21Z4v
 4DgYbGtJsCx9d64eXXg==
X-Proofpoint-ORIG-GUID: JFyzaFsxLLeokKdLql8AkTKZh4UfDV6_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_04,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602270174
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=jithu.joseph@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2/26/2026 11:51 PM, Cédric Le Goater wrote:
> Hello Jithu,
> 
> On 2/27/26 03:23, Jithu Joseph wrote:
>>

...

>>
>>> +
>>> +int i3c_send_byte(I3CBus *bus, uint8_t data)
>>> +{
>>> +    /*
>>> +     * Ignored, the caller can determine how many were sent based on if this was
>>> +     * ACKed/NACKed.
>>> +     */
>>> +    uint32_t num_sent;
>>
>> num_sent is uninitialized here. Even though i3c_send_byte ignores it after the call, it gets passed by pointer into i3c_send() where it is used in the trace_i3c_send() call.
>> If the send callback does not write *num_sent (as is the case with mock_i3c_target_tx, refer my prev comment for patch 18/22), the trace might show garbage. Initializing it to zero might reduce the confusion
> 
> Could please send a patch ? I will queue it after this series.

Got it,  I will send 2 patches one to address this comment and another one to address my comment on 18/22, which will apply  on-top of this series

> 
> Also, since you have tested this series, would mind sending
> a Tested-by tag ? possibly a Reviewed-by too.

You can add my Tested-by for the whole series , I have replied to the cover-letter with the tag .

I will send in Reviewed-by for the couple of patches I sent review comments for


Jithu

 

